package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.entity.KnowledgeChunk;
import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.mapper.KnowledgeChunkMapper;
import com.school.itas.mapper.KnowledgeDocumentMapper;
import com.school.itas.model.req.KnowledgeDocReq;
import com.school.itas.rag.embedding.EmbeddingService;
import com.school.itas.rag.parser.DocumentParser;
import com.school.itas.rag.splitter.TextSplitter;
import com.school.itas.service.KnowledgeService;
import io.milvus.client.MilvusServiceClient;
import io.milvus.param.dml.InsertParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeServiceImpl implements KnowledgeService {

    private final KnowledgeDocumentMapper docMapper;
    private final KnowledgeChunkMapper chunkMapper;
    private final DocumentParser documentParser;
    private final TextSplitter textSplitter;
    private final EmbeddingService embeddingService;
    private final MilvusServiceClient milvusServiceClient;

    @Value("${itas.upload.path:./uploads/}")
    private String uploadPath;

    @Value("${milvus.collection-name}")
    private String collectionName;

    @Override
    @Transactional
    public KnowledgeDocument uploadDocument(Long uploaderId, KnowledgeDocReq req, MultipartFile file) {
        // 保存文件到本地
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        String filePath = uploadPath + fileName;
        File dest = new File(filePath);
        dest.getParentFile().mkdirs();
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            throw new BusinessException("文件保存失败: " + e.getMessage());
        }

        // 获取文件类型
        String originalName = file.getOriginalFilename();
        String fileType = originalName != null && originalName.contains(".")
                ? originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase()
                : "unknown";

        KnowledgeDocument doc = new KnowledgeDocument();
        doc.setTitle(req.getTitle());
        doc.setSubject(req.getSubject());
        doc.setFileName(originalName);
        doc.setFilePath(filePath);
        doc.setFileType(fileType);
        doc.setFileSize(file.getSize());
        doc.setChunkCount(0);
        doc.setStatus(0);
        doc.setUploaderId(uploaderId);
        docMapper.insert(doc);

        // 异步向量化（此处同步执行，生产环境可改为异步）
        vectorizeDocument(doc.getId());
        return doc;
    }

    @Override
    public List<KnowledgeDocument> listDocuments(String subject, Integer page, Integer size) {
        LambdaQueryWrapper<KnowledgeDocument> wrapper = new LambdaQueryWrapper<>();
        if (subject != null && !subject.isBlank()) {
            wrapper.eq(KnowledgeDocument::getSubject, subject);
        }
        wrapper.orderByDesc(KnowledgeDocument::getCreatedAt);
        return docMapper.selectList(wrapper);
    }

    @Override
    @Transactional
    public void deleteDocument(Long docId) {
        docMapper.deleteById(docId);
        chunkMapper.delete(new LambdaQueryWrapper<KnowledgeChunk>()
                .eq(KnowledgeChunk::getDocId, docId));
    }

    @Override
    @Transactional
    public void vectorizeDocument(Long docId) {
        KnowledgeDocument doc = docMapper.selectById(docId);
        if (doc == null) throw new BusinessException("文档不存在");

        doc.setStatus(1);
        docMapper.updateById(doc);

        try {
            // 解析文本
            File file = new File(doc.getFilePath());
            String text = documentParser.parse(new java.io.FileInputStream(file));

            // 分块
            List<String> chunks = textSplitter.split(text);

            // 批量 embedding 并写入 Milvus + MySQL
            List<Long> docIds = new ArrayList<>();
            List<Long> chunkDbIds = new ArrayList<>();
            List<String> subjects = new ArrayList<>();
            List<List<Float>> vectors = new ArrayList<>();

            for (int i = 0; i < chunks.size(); i++) {
                String chunkText = chunks.get(i);

                // 先存 MySQL 获取 chunk id
                KnowledgeChunk chunk = new KnowledgeChunk();
                chunk.setDocId(docId);
                chunk.setChunkIndex(i);
                chunk.setContent(chunkText);
                chunk.setTokenCount(chunkText.length() / 2);
                chunkMapper.insert(chunk);

                float[] vec = embeddingService.embed(chunkText);
                List<Float> vecList = new ArrayList<>();
                for (float v : vec) vecList.add(v);

                docIds.add(docId);
                chunkDbIds.add(chunk.getId());
                subjects.add(doc.getSubject());
                vectors.add(vecList);
            }

            // 批量写入 Milvus
            if (!vectors.isEmpty()) {
                List<InsertParam.Field> fields = List.of(
                        new InsertParam.Field("doc_id", docIds),
                        new InsertParam.Field("chunk_id", chunkDbIds),
                        new InsertParam.Field("subject", subjects),
                        new InsertParam.Field("vector", vectors)
                );
                InsertParam insertParam = InsertParam.newBuilder()
                        .withCollectionName(collectionName)
                        .withFields(fields)
                        .build();
                var insertResp = milvusServiceClient.insert(insertParam);

                // 回写 milvus_id 到 MySQL chunk 表
                List<Long> milvusIds = insertResp.getData().getIDs().getIntId().getDataList();
                for (int i = 0; i < chunkDbIds.size(); i++) {
                    KnowledgeChunk c = new KnowledgeChunk();
                    c.setId(chunkDbIds.get(i));
                    c.setMilvusId(milvusIds.get(i));
                    chunkMapper.updateById(c);
                }
            }

            doc.setChunkCount(chunks.size());
            doc.setStatus(2);
            docMapper.updateById(doc);
            log.info("Document {} vectorized: {} chunks", docId, chunks.size());

        } catch (Exception e) {
            doc.setStatus(3);
            docMapper.updateById(doc);
            log.error("Vectorize document {} failed", docId, e);
            throw new BusinessException("向量化失败: " + e.getMessage());
        }
    }
}

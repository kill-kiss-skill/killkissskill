package com.school.itas.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.entity.KnowledgeChunk;
import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.entity.KnowledgeImportTask;
import com.school.itas.mapper.KnowledgeChunkMapper;
import com.school.itas.mapper.KnowledgeDocumentMapper;
import com.school.itas.mapper.KnowledgeImportTaskMapper;
import com.school.itas.model.resp.ImportProgressResp;
import com.school.itas.rag.embedding.EmbeddingRateLimiter;
import com.school.itas.rag.embedding.EmbeddingService;
import com.school.itas.rag.hash.TextHashService;
import com.school.itas.rag.splitter.TextSplitter;
import com.school.itas.rag.subject.SubjectMapper;
import io.milvus.client.MilvusServiceClient;
import io.milvus.param.dml.InsertParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
public class BulkKnowledgeImporter {

    private final KnowledgeDocumentMapper docMapper;
    private final KnowledgeChunkMapper chunkMapper;
    private final KnowledgeImportTaskMapper taskMapper;
    private final TextSplitter textSplitter;
    private final EmbeddingService embeddingService;
    private final EmbeddingRateLimiter rateLimiter;
    private final TextHashService textHashService;
    private final SubjectMapper subjectMapper;
    private final MilvusServiceClient milvusServiceClient;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${milvus.collection-name}")
    private String collectionName;

    @Value("${itas.import.batch-size:50}")
    private int batchSize;

    @Transactional(rollbackFor = Exception.class)
    public ImportProgressResp importFromJsonl(InputStream jsonlStream, String datasetName,
                                               String subjectFilter, Long operatorId) {
        String batchNo = UUID.randomUUID().toString().replace("-", "").substring(0, 16);
        KnowledgeImportTask task = createTask(batchNo, datasetName, subjectFilter, operatorId);
        taskMapper.insert(task);

        List<String> embedTexts = new ArrayList<>();
        List<Long> chunkDbIds = new ArrayList<>();
        List<Long> docIdsForChunks = new ArrayList<>();
        List<String> subjectsForChunks = new ArrayList<>();
        int totalItems = 0, successItems = 0, skipItems = 0, failItems = 0;
        int totalChunks = 0;

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(jsonlStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.isBlank()) continue;
                totalItems++;

                try {
                    JsonNode node = objectMapper.readTree(line);

                    String rawSubject = node.has("subject") ? node.get("subject").asText() : null;
                    String sysSubject = subjectMapper.map(datasetName, rawSubject);
                    if (sysSubject == null) {
                        skipItems++;
                        continue;
                    }
                    if (subjectFilter != null && !subjectFilter.equals(sysSubject)) {
                        skipItems++;
                        continue;
                    }

                    String content = node.has("content") ? node.get("content").asText() : "";
                    if (content.isBlank()) {
                        skipItems++;
                        continue;
                    }

                    // 分块
                    List<String> chunks = textSplitter.split(content);
                    if (chunks.isEmpty()) {
                        skipItems++;
                        continue;
                    }

                    // 去重
                    List<String> newChunks = textHashService.filterNewChunks(chunks);
                    if (newChunks.isEmpty()) {
                        skipItems++;
                        continue;
                    }

                    // 创建 KnowledgeDocument
                    KnowledgeDocument doc = new KnowledgeDocument();
                    doc.setTitle(node.has("title") ? node.get("title").asText() : sysSubject);
                    doc.setSubject(sysSubject);
                    doc.setFileName(datasetName + ".jsonl");
                    doc.setFilePath("");
                    doc.setFileType("jsonl");
                    doc.setFileSize((long) content.length());
                    doc.setChunkCount(newChunks.size());
                    doc.setStatus(2);
                    doc.setUploaderId(operatorId);
                    doc.setSource(datasetName);
                    doc.setSourceUrl(node.has("source_id") ? node.get("source_id").asText() : null);
                    docMapper.insert(doc);

                    // 存 MySQL chunk 并累积 embedding
                    for (int i = 0; i < newChunks.size(); i++) {
                        String chunkText = newChunks.get(i);
                        KnowledgeChunk chunk = new KnowledgeChunk();
                        chunk.setDocId(doc.getId());
                        chunk.setChunkIndex(i);
                        chunk.setContent(chunkText);
                        chunk.setTokenCount(chunkText.length() / 2);
                        chunk.setContentHash(textHashService.hash(chunkText));
                        chunk.setSource(datasetName);
                        chunkMapper.insert(chunk);

                        embedTexts.add(chunkText);
                        chunkDbIds.add(chunk.getId());
                        docIdsForChunks.add(doc.getId());
                        subjectsForChunks.add(sysSubject);
                    }

                    totalChunks += newChunks.size();
                    successItems++;

                    // 满一批就 flush 到 Milvus
                    if (embedTexts.size() >= batchSize) {
                        flushEmbedBatch(embedTexts, chunkDbIds, docIdsForChunks, subjectsForChunks);
                        embedTexts.clear();
                        chunkDbIds.clear();
                        docIdsForChunks.clear();
                        subjectsForChunks.clear();
                    }

                } catch (Exception e) {
                    failItems++;
                    log.warn("Failed to process JSONL item #{}: {}", totalItems, e.getMessage());
                }

                // 定期更新任务进度
                if (totalItems % (batchSize * 2) == 0) {
                    task.setTotalItems(totalItems);
                    task.setSuccessItems(successItems);
                    task.setSkipItems(skipItems);
                    task.setFailItems(failItems);
                    task.setTotalChunks(totalChunks);
                    taskMapper.updateById(task);
                }
            }

            // 处理最后一批
            if (!embedTexts.isEmpty()) {
                flushEmbedBatch(embedTexts, chunkDbIds, docIdsForChunks, subjectsForChunks);
            }

        } catch (IOException e) {
            task.setStatus(2);
            task.setErrorMsg("IO异常: " + e.getMessage());
            taskMapper.updateById(task);
            throw new BusinessException("导入失败: " + e.getMessage());
        }

        task.setTotalItems(totalItems);
        task.setSuccessItems(successItems);
        task.setSkipItems(skipItems);
        task.setFailItems(failItems);
        task.setTotalChunks(totalChunks);
        task.setStatus(1);
        taskMapper.updateById(task);

        log.info("Import batch {} completed: total={}, success={}, skip={}, fail={}, chunks={}",
                batchNo, totalItems, successItems, skipItems, failItems, totalChunks);

        return buildProgress(task);
    }

    private void flushEmbedBatch(List<String> texts, List<Long> chunkIds,
                                  List<Long> docIds, List<String> subjects) {
        rateLimiter.acquire(texts.size());

        List<float[]> embeddings = embeddingService.embedBatch(texts);

        List<List<Float>> vectors = new ArrayList<>();
        for (float[] vec : embeddings) {
            List<Float> vecList = new ArrayList<>();
            for (float v : vec) vecList.add(v);
            vectors.add(vecList);
        }

        List<InsertParam.Field> fields = List.of(
                new InsertParam.Field("doc_id", docIds),
                new InsertParam.Field("chunk_id", chunkIds),
                new InsertParam.Field("subject", subjects),
                new InsertParam.Field("vector", vectors)
        );
        InsertParam insertParam = InsertParam.newBuilder()
                .withCollectionName(collectionName)
                .withFields(fields)
                .build();
        var insertResp = milvusServiceClient.insert(insertParam);
        if (insertResp.getStatus() != 0 || insertResp.getData() == null) {
            throw new BusinessException("Milvus写入失败: " + insertResp.getMessage());
        }

        List<Long> milvusIds = insertResp.getData().getIDs().getIntId().getDataList();
        for (int i = 0; i < chunkIds.size(); i++) {
            KnowledgeChunk c = new KnowledgeChunk();
            c.setId(chunkIds.get(i));
            c.setMilvusId(milvusIds.get(i));
            chunkMapper.updateById(c);
        }

        log.debug("Flushed {} embeddings to Milvus", texts.size());
    }

    private KnowledgeImportTask createTask(String batchNo, String datasetName,
                                            String subjectFilter, Long operatorId) {
        KnowledgeImportTask task = new KnowledgeImportTask();
        task.setBatchNo(batchNo);
        task.setDatasetName(datasetName);
        task.setSubject(subjectFilter);
        task.setTotalItems(0);
        task.setSuccessItems(0);
        task.setSkipItems(0);
        task.setFailItems(0);
        task.setTotalChunks(0);
        task.setStatus(0);
        task.setOperatorId(operatorId);
        return task;
    }

    public ImportProgressResp getProgress(String batchNo) {
        KnowledgeImportTask task = taskMapper.selectOne(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<KnowledgeImportTask>()
                        .eq(KnowledgeImportTask::getBatchNo, batchNo));
        if (task == null) throw new BusinessException(404, "任务不存在");
        return buildProgress(task);
    }

    public List<KnowledgeImportTask> listTasks(int page, int size) {
        return taskMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<KnowledgeImportTask>()
                        .orderByDesc(KnowledgeImportTask::getCreatedAt)
                        .last("LIMIT " + ((page - 1) * size) + "," + size));
    }

    private ImportProgressResp buildProgress(KnowledgeImportTask task) {
        ImportProgressResp resp = new ImportProgressResp();
        resp.setBatchNo(task.getBatchNo());
        resp.setDatasetName(task.getDatasetName());
        resp.setSubject(task.getSubject());
        resp.setTotalItems(task.getTotalItems());
        resp.setSuccessItems(task.getSuccessItems());
        resp.setSkipItems(task.getSkipItems());
        resp.setFailItems(task.getFailItems());
        resp.setTotalChunks(task.getTotalChunks());
        resp.setStatus(task.getStatus());
        resp.setErrorMsg(task.getErrorMsg());
        resp.setCreatedAt(task.getCreatedAt());
        return resp;
    }
}

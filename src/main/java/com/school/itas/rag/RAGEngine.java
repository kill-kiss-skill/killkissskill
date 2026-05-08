package com.school.itas.rag;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.entity.KnowledgeChunk;
import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.mapper.KnowledgeChunkMapper;
import com.school.itas.mapper.KnowledgeDocumentMapper;
import com.school.itas.model.dto.RagResultDTO;
import com.school.itas.rag.reranker.Reranker;
import com.school.itas.rag.retriever.MilvusRetriever;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class RAGEngine {

    private final MilvusRetriever retriever;
    private final Reranker reranker;
    private final KnowledgeChunkMapper chunkMapper;
    private final KnowledgeDocumentMapper docMapper;

    @Value("${itas.rag.top-k:5}")
    private int topK;

    public RagResultDTO query(String question, String subject) {
        // 1. 向量检索
        List<RagResultDTO.ChunkDTO> candidates = retriever.retrieve(question, subject);
        if (candidates.isEmpty()) {
            RagResultDTO empty = new RagResultDTO();
            empty.setChunks(List.of());
            empty.setContextText("");
            return empty;
        }

        // 2. 回查 MySQL 获取原文
        List<Long> chunkIds = candidates.stream().map(RagResultDTO.ChunkDTO::getChunkId).toList();
        List<KnowledgeChunk> chunks = chunkMapper.selectList(
                new LambdaQueryWrapper<KnowledgeChunk>().in(KnowledgeChunk::getId, chunkIds));

        Map<Long, KnowledgeChunk> chunkMap = chunks.stream()
                .collect(Collectors.toMap(KnowledgeChunk::getId, c -> c));

        // 3. 填充原文内容
        candidates.forEach(dto -> {
            KnowledgeChunk chunk = chunkMap.get(dto.getChunkId());
            if (chunk != null) dto.setContent(chunk.getContent());
        });

        // 4. 回查文档标题
        List<Long> docIds = candidates.stream().map(RagResultDTO.ChunkDTO::getDocId).distinct().toList();
        Map<Long, String> docTitleMap = docMapper.selectList(
                new LambdaQueryWrapper<KnowledgeDocument>().in(KnowledgeDocument::getId, docIds))
                .stream().collect(Collectors.toMap(KnowledgeDocument::getId, KnowledgeDocument::getTitle));
        candidates.forEach(dto -> dto.setDocTitle(docTitleMap.getOrDefault(dto.getDocId(), "")));

        // 5. 重排序
        List<RagResultDTO.ChunkDTO> reranked = reranker.rerank(question, candidates);

        // 6. 拼装上下文文本
        String contextText = reranked.stream()
                .map(dto -> "[来源: " + dto.getDocTitle() + "]\n" + dto.getContent())
                .collect(Collectors.joining("\n\n---\n\n"));

        RagResultDTO result = new RagResultDTO();
        result.setChunks(reranked);
        result.setContextText(contextText);
        return result;
    }
}

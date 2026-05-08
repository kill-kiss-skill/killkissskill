package com.school.itas.rag.retriever;

import com.school.itas.model.dto.RagResultDTO;
import com.school.itas.rag.embedding.EmbeddingService;
import io.milvus.client.MilvusServiceClient;
import io.milvus.param.MetricType;
import io.milvus.param.dml.SearchParam;
import io.milvus.response.SearchResultsWrapper;
import io.milvus.grpc.SearchResults;
import io.milvus.param.R;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class MilvusRetriever {

    private final MilvusServiceClient milvusServiceClient;
    private final EmbeddingService embeddingService;

    @Value("${milvus.collection-name}")
    private String collectionName;

    @Value("${itas.rag.top-k:5}")
    private int topK;

    public List<RagResultDTO.ChunkDTO> retrieve(String query, String subject) {
        float[] queryVector = embeddingService.embed(query);

        List<Float> vectorList = new ArrayList<>();
        for (float v : queryVector) vectorList.add(v);

        String expr = subject != null && !subject.isBlank()
                ? "subject == \"" + subject + "\""
                : "";

        SearchParam.Builder builder = SearchParam.newBuilder()
                .withCollectionName(collectionName)
                .withMetricType(MetricType.IP)
                .withOutFields(List.of("doc_id", "chunk_id", "subject"))
                .withTopK(topK)
                .withVectors(List.of(vectorList))
                .withVectorFieldName("vector")
                .withParams("{\"nprobe\":16}");

        if (!expr.isBlank()) builder.withExpr(expr);

        R<SearchResults> response = milvusServiceClient.search(builder.build());
        if (response.getStatus() != 0) {
            log.warn("Milvus search failed: {}", response.getMessage());
            return List.of();
        }

        SearchResultsWrapper wrapper = new SearchResultsWrapper(response.getData().getResults());
        List<RagResultDTO.ChunkDTO> results = new ArrayList<>();
        for (int i = 0; i < wrapper.getRowRecords(0).size(); i++) {
            SearchResultsWrapper.IDScore idScore = wrapper.getIDScore(0).get(i);
            RagResultDTO.ChunkDTO dto = new RagResultDTO.ChunkDTO();
            dto.setScore(idScore.getScore());
            // milvus_id 对应 chunk_id，后续由 RAGEngine 回查 MySQL 获取原文
            dto.setChunkId((Long) wrapper.getFieldData("chunk_id", 0).get(i));
            dto.setDocId((Long) wrapper.getFieldData("doc_id", 0).get(i));
            results.add(dto);
        }
        return results;
    }
}

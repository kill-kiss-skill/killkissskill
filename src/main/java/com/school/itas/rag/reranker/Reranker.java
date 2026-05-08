package com.school.itas.rag.reranker;

import com.school.itas.model.dto.RagResultDTO;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class Reranker {

    /**
     * BM25 关键词分数与向量分数加权融合重排序
     * vectorWeight + keywordWeight = 1.0
     */
    public List<RagResultDTO.ChunkDTO> rerank(String query, List<RagResultDTO.ChunkDTO> candidates,
                                               float vectorWeight, float keywordWeight) {
        Set<String> queryTokens = tokenize(query);
        candidates.forEach(c -> {
            float kwScore = bm25Score(queryTokens, c.getContent());
            c.setScore(c.getScore() * vectorWeight + kwScore * keywordWeight);
        });
        candidates.sort((a, b) -> Float.compare(b.getScore(), a.getScore()));
        return candidates;
    }

    public List<RagResultDTO.ChunkDTO> rerank(String query, List<RagResultDTO.ChunkDTO> candidates) {
        return rerank(query, candidates, 0.7f, 0.3f);
    }

    private float bm25Score(Set<String> queryTokens, String content) {
        if (content == null || content.isBlank()) return 0f;
        Set<String> contentTokens = tokenize(content);
        long matched = queryTokens.stream().filter(contentTokens::contains).count();
        return (float) matched / queryTokens.size();
    }

    private Set<String> tokenize(String text) {
        return Arrays.stream(text.toLowerCase().split("[\\s，。、：；！？,.!?;:]+"))
                .filter(s -> !s.isBlank())
                .collect(Collectors.toSet());
    }
}

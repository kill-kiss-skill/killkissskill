package com.school.itas.rag.embedding;

import lombok.RequiredArgsConstructor;
import org.springframework.ai.embedding.Embedding;
import org.springframework.ai.embedding.EmbeddingRequest;
import org.springframework.ai.embedding.EmbeddingResponse;
import org.springframework.ai.openai.OpenAiEmbeddingModel;
import org.springframework.ai.openai.OpenAiEmbeddingOptions;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
@RequiredArgsConstructor
public class EmbeddingService {

    private final OpenAiEmbeddingModel embeddingModel;

    public float[] embed(String text) {
        return embeddingModel.embed(text);
    }

    public List<float[]> embedBatch(List<String> texts) {
        if (texts.isEmpty()) return List.of();
        EmbeddingRequest request = new EmbeddingRequest(texts,
                OpenAiEmbeddingOptions.builder().build());
        EmbeddingResponse response = embeddingModel.call(request);
        return response.getResults().stream()
                .map(Embedding::getOutput)
                .toList();
    }
}

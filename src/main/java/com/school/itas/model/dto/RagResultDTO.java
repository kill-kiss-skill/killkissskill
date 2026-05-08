package com.school.itas.model.dto;

import lombok.Data;

import java.util.List;

@Data
public class RagResultDTO {
    private List<ChunkDTO> chunks;
    private String contextText;

    @Data
    public static class ChunkDTO {
        private Long chunkId;
        private Long docId;
        private String docTitle;
        private String content;
        private float score;
    }
}

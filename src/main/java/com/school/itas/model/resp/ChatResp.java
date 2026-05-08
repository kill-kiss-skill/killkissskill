package com.school.itas.model.resp;

import lombok.Data;

import java.util.List;

@Data
public class ChatResp {
    private String sessionKey;
    private String role;
    private String answer;
    private List<ChunkRef> references;

    @Data
    public static class ChunkRef {
        private Long chunkId;
        private String docTitle;
        private String content;
    }
}

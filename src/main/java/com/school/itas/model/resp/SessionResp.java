package com.school.itas.model.resp;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SessionResp {
    private String sessionKey;
    private String title;
    private String agentType;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

package com.school.itas.model.resp;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ResourceResp {
    private Long id;
    private String title;
    private String subject;
    private String resType;
    private String url;
    private String description;
    private Integer difficulty;
    private Integer viewCount;
    private LocalDateTime createdAt;
}

package com.school.itas.model.resp;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class LearningPlanResp {
    private Long id;
    private Long studentId;
    private String planTitle;
    private String content;
    private String weakSubjects;
    private String semester;
    private String generatedBy;
    private Integer status;
    private LocalDateTime createdAt;
    private List<PlanItemResp> items;

    @Data
    public static class PlanItemResp {
        private Long id;
        private String subject;
        private String taskDesc;
        private String resourceUrl;
        private Integer priority;
        private Integer status;
        private LocalDate dueDate;
    }
}

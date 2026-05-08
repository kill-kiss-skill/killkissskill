package com.school.itas.model.resp;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Data
public class ScoreAnalysisResp {
    private Long studentId;
    private String studentName;
    private List<SubjectAvg> subjectAvgList;
    private List<String> weakSubjects;
    private String analysisText;

    @Data
    public static class SubjectAvg {
        private String subject;
        private BigDecimal avgScore;
        private String gradeLevel;
    }
}

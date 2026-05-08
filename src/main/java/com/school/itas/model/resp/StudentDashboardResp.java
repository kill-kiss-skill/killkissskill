package com.school.itas.model.resp;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Data
public class StudentDashboardResp {
    private Integer totalScores;
    private Integer passCount;
    private Integer failCount;
    private Integer planCount;
    private List<SubjectAvg> subjectAvgs;
    private Map<String, Integer> gradeDistribution;
    private List<SemesterTrend> semesterTrends;

    @Data
    public static class SubjectAvg {
        private String subject;
        private BigDecimal avgScore;
        private String gradeLevel;
    }

    @Data
    public static class SemesterTrend {
        private String semester;
        private BigDecimal avgScore;
    }
}

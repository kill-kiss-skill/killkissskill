package com.school.itas.model.resp;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Data
public class TeacherDashboardResp {
    private Integer totalStudents;
    private Integer totalCourses;
    private BigDecimal overallPassRate;
    private Integer totalDocs;
    private Map<String, Integer> gradeDistribution;
    private List<CourseAvg> courseAvgs;

    @Data
    public static class CourseAvg {
        private String courseName;
        private String subject;
        private BigDecimal avgScore;
        private Long studentCount;
    }
}

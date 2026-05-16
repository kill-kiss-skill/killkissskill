package com.school.itas.model.resp;

import lombok.Data;

import java.util.Map;

@Data
public class AdminDashboardResp {
    private Long totalUsers;
    private Long adminCount;
    private Long teacherCount;
    private Long studentCount;
    private Long totalDocs;
    private Long totalScores;
    private Long totalPlans;
    private Long aiAnalysisCount;
    private Map<String, Long> scoreDistribution;
}

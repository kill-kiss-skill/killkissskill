package com.school.itas.model.resp;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class ScoreResp {
    private Long id;
    private String studentName;
    private String studentNo;
    private String courseName;
    private String subject;
    private BigDecimal usualScore;
    private BigDecimal midScore;
    private BigDecimal finalScore;
    private BigDecimal totalScore;
    private String gradeLevel;
    private Integer isPass;
    private String semester;
}

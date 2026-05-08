package com.school.itas.model.resp;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class TeacherStudentResp {
    private Long studentId;
    private String studentName;
    private String studentNo;
    private String className;
    private BigDecimal avgScore;
    private Integer scoreCount;
}

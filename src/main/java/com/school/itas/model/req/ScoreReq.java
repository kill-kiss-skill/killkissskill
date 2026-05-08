package com.school.itas.model.req;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ScoreReq {

    @NotNull(message = "学生ID不能为空")
    private Long studentId;

    @NotNull(message = "课程ID不能为空")
    private Long courseId;

    private BigDecimal usualScore;
    private BigDecimal midScore;
    private BigDecimal finalScore;

    @NotNull(message = "学期不能为空")
    private String semester;

    private String remark;
}

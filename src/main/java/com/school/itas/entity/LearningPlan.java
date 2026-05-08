package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("learning_plan")
public class LearningPlan {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long studentId;
    private String planTitle;
    private String content;
    private String weakSubjects;
    private String semester;
    private String generatedBy;
    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}

package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("learning_plan_item")
public class LearningPlanItem {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long planId;
    private String subject;
    private String taskDesc;
    private String resourceUrl;
    private Integer priority;
    private Integer status;
    private LocalDate dueDate;
}

package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("course")
public class Course {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String courseCode;
    private String courseName;
    private String subject;
    private BigDecimal credit;
    private Long teacherId;
    private String semester;
    private Long classId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}

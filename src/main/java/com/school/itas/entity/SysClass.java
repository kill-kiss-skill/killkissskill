package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_class")
public class SysClass {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String className;
    private Long departmentId;
    private Integer grade;
    private Long teacherId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}

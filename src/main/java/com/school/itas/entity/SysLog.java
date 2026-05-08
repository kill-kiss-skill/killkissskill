package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sys_log")
public class SysLog {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String module;
    private String action;
    private String method;
    private String requestUrl;
    private String ip;
    private Integer status;
    private Integer costMs;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}

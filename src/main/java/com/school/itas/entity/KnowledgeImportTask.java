package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("knowledge_import_task")
public class KnowledgeImportTask {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String batchNo;

    private String datasetName;

    private String subject;

    private Integer totalItems;

    private Integer successItems;

    private Integer skipItems;

    private Integer failItems;

    private Integer totalChunks;

    private Integer status;

    private String errorMsg;

    private Long operatorId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}

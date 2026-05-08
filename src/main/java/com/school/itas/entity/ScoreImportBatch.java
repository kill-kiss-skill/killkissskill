package com.school.itas.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("score_import_batch")
public class ScoreImportBatch {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String batchNo;
    private String fileName;
    private Long courseId;
    private String semester;
    private Integer totalRows;
    private Integer successRows;
    private Integer failRows;
    private Integer status;
    private Long operatorId;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}

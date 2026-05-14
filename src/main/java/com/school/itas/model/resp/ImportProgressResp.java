package com.school.itas.model.resp;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ImportProgressResp {

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
    private LocalDateTime createdAt;
}

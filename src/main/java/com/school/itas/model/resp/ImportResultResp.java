package com.school.itas.model.resp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.ArrayList;
import java.util.List;

@Data
public class ImportResultResp {
    private String batchNo;
    private int totalRows;
    private int successRows;
    private int failRows;
    private List<ImportError> errors = new ArrayList<>();

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ImportError {
        private int row;
        private String reason;
    }
}

package com.school.itas.model.req;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class KnowledgeDocReq {

    @NotBlank(message = "文档标题不能为空")
    private String title;

    @NotBlank(message = "学科不能为空")
    private String subject;
}

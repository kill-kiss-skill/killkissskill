package com.school.itas.model.req;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ResourceReq {

    @NotBlank(message = "标题不能为空")
    private String title;

    @NotBlank(message = "学科不能为空")
    private String subject;

    @NotBlank(message = "资源类型不能为空")
    private String resType;

    private String url;
    private String description;

    @NotNull(message = "难度不能为空")
    private Integer difficulty;
}

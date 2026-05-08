package com.school.itas.model.req;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ChatReq {

    @NotBlank(message = "消息内容不能为空")
    private String message;

    private String sessionKey;

    @NotBlank(message = "学科不能为空")
    private String subject;
}

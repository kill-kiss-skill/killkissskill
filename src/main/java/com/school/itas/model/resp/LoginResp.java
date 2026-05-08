package com.school.itas.model.resp;

import lombok.Data;

@Data
public class LoginResp {
    private String token;
    private Long userId;
    private String username;
    private String realName;
    private Integer role;
}

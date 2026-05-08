package com.school.itas.model.resp;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserInfoResp {
    private Long id;
    private String username;
    private String realName;
    private Integer role;
    private String email;
    private String phone;
    private String avatarUrl;
    private Integer status;
    private Long studentInfoId;
    private Long teacherInfoId;
    private LocalDateTime createdAt;
}

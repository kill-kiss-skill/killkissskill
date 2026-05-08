package com.school.itas.common.enums;

import lombok.Getter;

@Getter
public enum RoleEnum {
    ADMIN(0, "ROLE_ADMIN"),
    TEACHER(1, "ROLE_TEACHER"),
    STUDENT(2, "ROLE_STUDENT");

    private final int code;
    private final String authority;

    RoleEnum(int code, String authority) {
        this.code = code;
        this.authority = authority;
    }

    public static RoleEnum of(int code) {
        for (RoleEnum r : values()) {
            if (r.code == code) return r;
        }
        throw new IllegalArgumentException("Unknown role code: " + code);
    }
}

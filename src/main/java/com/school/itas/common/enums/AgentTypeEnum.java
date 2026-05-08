package com.school.itas.common.enums;

import lombok.Getter;

@Getter
public enum AgentTypeEnum {
    CHAT("CHAT", "知识问答"),
    ANALYZE("ANALYZE", "成绩分析"),
    RESOURCE("RESOURCE", "资源推荐");

    private final String code;
    private final String desc;

    AgentTypeEnum(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }
}

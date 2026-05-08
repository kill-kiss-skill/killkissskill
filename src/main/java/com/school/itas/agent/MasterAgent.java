package com.school.itas.agent;

import com.school.itas.common.enums.AgentTypeEnum;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class MasterAgent {

    private final ChatClient chatClient;

    private static final String ROUTE_PROMPT =
            "你是一个智能路由助手，根据用户输入判断意图类型。\n" +
            "只返回以下三个标签之一，不要有任何其他内容：\n" +
            "- ANALYZE：成绩分析、薄弱科目、学习情况、成绩统计相关\n" +
            "- RESOURCE：推荐学习资源、视频、书籍、练习题相关\n" +
            "- CHAT：其他所有问题，包括知识问答、概念解释等\n\n" +
            "用户输入：{input}";

    public AgentTypeEnum route(String userInput) {
        String result = chatClient.prompt()
                .user(ROUTE_PROMPT.replace("{input}", userInput))
                .call()
                .content()
                .trim()
                .toUpperCase();

        log.debug("MasterAgent route result: {} for input: {}", result, userInput);

        return switch (result) {
            case "ANALYZE"  -> AgentTypeEnum.ANALYZE;
            case "RESOURCE" -> AgentTypeEnum.RESOURCE;
            default         -> AgentTypeEnum.CHAT;
        };
    }
}

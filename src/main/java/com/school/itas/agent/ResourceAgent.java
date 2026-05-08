package com.school.itas.agent;

import com.school.itas.entity.LearningResource;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class ResourceAgent {

    private final ChatClient chatClient;

    private static final String PROMPT_TEMPLATE =
            "你是ITAS智能教学辅助系统的学习资源推荐助手。\n\n" +
            "学生薄弱科目：{weakSubjects}\n" +
            "当前学期：{semester}\n\n" +
            "可用资源列表：\n{resourceList}\n\n" +
            "请根据学生的薄弱科目，从可用资源列表中推荐最合适的3-5个学习资源。\n" +
            "如果可用资源不足，可以给出通用的学习建议。\n" +
            "输出要求：按优先级排列，说明每个资源的推荐理由，语气友好鼓励，使用中文。";

    public String recommend(List<String> weakSubjects, String semester, List<LearningResource> resources) {
        StringBuilder resourceList = new StringBuilder();
        for (LearningResource r : resources) {
            resourceList.append("- [").append(r.getResType()).append("] ")
                    .append(r.getTitle())
                    .append("（学科：").append(r.getSubject())
                    .append("，难度：").append(r.getDifficulty()).append("）")
                    .append(r.getDescription() != null ? "：" + r.getDescription() : "")
                    .append("\n");
        }

        String prompt = PROMPT_TEMPLATE
                .replace("{weakSubjects}", String.join("、", weakSubjects))
                .replace("{semester}", semester != null ? semester : "当前学期")
                .replace("{resourceList}", resourceList.isEmpty() ? "（暂无资源）" : resourceList.toString());

        return chatClient.prompt()
                .user(prompt)
                .call()
                .content();
    }
}

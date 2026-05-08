package com.school.itas.agent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class LearningAnalyzeAgent {

    private final ChatClient chatClient;

    private static final String PROMPT_TEMPLATE =
            "你是ITAS智能教学辅助系统的成绩分析助手。\n\n" +
            "以下是学生【{studentName}】的成绩数据：\n{scoreData}\n\n" +
            "请完成以下分析任务：\n" +
            "1. 识别薄弱科目（平均分低于60分或明显低于其他科目的）\n" +
            "2. 分析成绩趋势（是否有进步或退步）\n" +
            "3. 给出针对性的学习建议\n" +
            "4. 生成一份简洁的个性化学习计划（包含3-5个具体任务）\n\n" +
            "输出格式：使用Markdown，包含薄弱科目分析、成绩趋势、学习建议、学习计划四个部分，语气鼓励专业。";

    public String analyze(String studentName, List<Map<String, Object>> scoreData) {
        StringBuilder sb = new StringBuilder();
        for (Map<String, Object> row : scoreData) {
            sb.append("- 课程：").append(row.get("course_name"))
              .append("，学科：").append(row.get("subject"))
              .append("，综合成绩：").append(row.get("total_score"))
              .append("，学期：").append(row.get("semester"))
              .append("\n");
        }

        String prompt = PROMPT_TEMPLATE
                .replace("{studentName}", studentName)
                .replace("{scoreData}", sb.toString());

        return chatClient.prompt()
                .user(prompt)
                .call()
                .content();
    }
}

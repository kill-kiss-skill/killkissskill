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
            "以下是学生【{studentName}】的成绩数据：\n\n{scoreData}\n\n" +
            "请完成以下分析任务：\n" +
            "1. 先用表格统计各科成绩（课程名称、成绩、等级、评价）\n" +
            "2. 识别薄弱科目（平均分低于60分或明显低于其他科目的），分析原因\n" +
            "3. 分析成绩趋势（按学期对比，是否有进步或退步）\n" +
            "4. 给出针对性的学习建议\n" +
            "5. 生成个性化学习计划（3-5个具体可执行任务）\n\n" +
            "输出格式要求：\n" +
            "- 全文使用Markdown格式\n" +
            "- 各科成绩使用Markdown表格展示\n" +
            "- 使用 ## 二级标题 和 ### 三级标题 组织内容\n" +
            "- 重要结论用 **粗体** 标注\n" +
            "- 语气鼓励、专业，面向学生直接对话";

    public String analyze(String studentName, List<Map<String, Object>> scoreData) {
        StringBuilder sb = new StringBuilder();
        sb.append("| 课程名称 | 学科 | 综合成绩 | 学期 |\n");
        sb.append("|----------|------|----------|------|\n");
        for (Map<String, Object> row : scoreData) {
            sb.append("| ").append(row.get("course_name"))
              .append(" | ").append(row.get("subject"))
              .append(" | ").append(row.get("total_score"))
              .append(" | ").append(row.get("semester"))
              .append(" |\n");
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

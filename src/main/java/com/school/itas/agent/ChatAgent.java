package com.school.itas.agent;

import com.school.itas.model.dto.RagResultDTO;
import com.school.itas.rag.RAGEngine;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ChatAgent {

    private final ChatClient chatClient;
    private final RAGEngine ragEngine;

    private static final String PROMPT_TEMPLATE =
            "你是ITAS智能教学辅助系统的学科知识助手。\n\n" +
            "请根据以下检索到的知识库内容，回答学生的问题。\n" +
            "回答要求：\n" +
            "1. 优先基于知识库内容作答，如知识库内容不足，可结合自身知识补充\n" +
            "2. 回答清晰、有条理，适当使用列表或分点说明\n" +
            "3. 如果引用了知识库内容，在回答末尾注明来源文档\n" +
            "4. 用中文回答\n\n" +
            "知识库检索内容：\n{context}\n\n" +
            "学生问题：{question}";

    public String answer(String question, String subject, RagResultDTO[] ragOut) {
        RagResultDTO rag = ragEngine.query(question, subject);
        if (ragOut != null && ragOut.length > 0) ragOut[0] = rag;

        String prompt = PROMPT_TEMPLATE
                .replace("{context}", rag.getContextText().isBlank() ? "（暂无相关知识库内容）" : rag.getContextText())
                .replace("{question}", question);

        return chatClient.prompt()
                .user(prompt)
                .call()
                .content();
    }
}

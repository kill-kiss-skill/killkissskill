package com.school.itas.config;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestClient;

import java.time.Duration;

/**
 * AI Agent 配置
 * Chat  → DeepSeek（OpenAI 兼容接口）
 * Embed → 智谱AI（OpenAI 兼容接口）
 */
@Configuration
public class ManusConfig {

    @Bean
    @Primary
    public ChatClient chatClient(OpenAiChatModel chatModel) {
        return ChatClient.builder(chatModel)
                .defaultSystem("你是ITAS智能教学辅助系统的AI助手，专注于帮助学生分析成绩、解答学科问题和制定学习计划。请用中文回答，保持专业、友好的语气。")
                .build();
    }

    @Bean
    @Primary
    public RestClient.Builder restClientBuilder() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(Duration.ofSeconds(30));
        factory.setReadTimeout(Duration.ofSeconds(180));
        return RestClient.builder().requestFactory(factory);
    }
}


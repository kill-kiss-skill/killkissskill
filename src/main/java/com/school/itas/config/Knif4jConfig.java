package com.school.itas.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Knif4jConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI().info(new Info()
                .title("ITAS 智能教学辅助系统 API")
                .description("基于RAG的学生成绩分析与个性化指导系统")
                .version("1.0.0"));
    }
}

package com.school.itas;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.school.itas.mapper")
public class ItasApplication {
    public static void main(String[] args) {
        SpringApplication.run(ItasApplication.class, args);
    }
}

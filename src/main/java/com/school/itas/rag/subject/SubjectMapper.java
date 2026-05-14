package com.school.itas.rag.subject;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Set;

@Slf4j
@Component
public class SubjectMapper {

    private static final Set<String> SYSTEM_SUBJECTS = Set.of(
            "数据结构", "操作系统", "计算机网络", "数据库原理", "算法设计与分析",
            "Java程序设计", "高等数学", "大学物理", "化学基础", "英语语法",
            "语文文学", "中国历史", "地理基础", "生物基础"
    );

    private static final Map<String, String> K12_MAPPING = Map.ofEntries(
            Map.entry("语文", "语文文学"),
            Map.entry("数学", "高等数学"),
            Map.entry("英语", "英语语法"),
            Map.entry("物理", "大学物理"),
            Map.entry("化学", "化学基础"),
            Map.entry("历史", "中国历史"),
            Map.entry("地理", "地理基础"),
            Map.entry("生物", "生物基础")
    );

    private static final Map<String, String> CEVAL_MAPPING = Map.ofEntries(
            Map.entry("高等数学", "高等数学"),
            Map.entry("大学物理", "大学物理"),
            Map.entry("数据结构", "数据结构"),
            Map.entry("操作系统", "操作系统"),
            Map.entry("计算机网络", "计算机网络"),
            Map.entry("数据库", "数据库原理"),
            Map.entry("数据库原理", "数据库原理"),
            Map.entry("Java程序设计", "Java程序设计"),
            Map.entry("大学化学", "化学基础"),
            Map.entry("算法设计", "算法设计与分析"),
            Map.entry("算法设计与分析", "算法设计与分析"),
            Map.entry("化学", "化学基础"),
            Map.entry("物理", "大学物理"),
            Map.entry("生物", "生物基础"),
            Map.entry("地理", "地理基础"),
            Map.entry("历史", "中国历史"),
            Map.entry("英语", "英语语法"),
            Map.entry("语文", "语文文学"),
            Map.entry("数学", "高等数学")
    );

    public String map(String datasetName, String rawSubject) {
        if (rawSubject == null || rawSubject.isBlank()) return null;

        String subject = rawSubject.trim();
        Map<String, String> mapping = switch (datasetName.toLowerCase()) {
            case "k12textbook" -> K12_MAPPING;
            case "ceval" -> CEVAL_MAPPING;
            default -> Map.of();
        };

        String mapped = mapping.getOrDefault(subject, null);

        if (mapped == null && SYSTEM_SUBJECTS.contains(subject)) {
            mapped = subject;
        }

        if (mapped != null && !SYSTEM_SUBJECTS.contains(mapped)) {
            log.warn("Subject '{}' mapped to unknown system subject '{}', skipping", subject, mapped);
            return null;
        }

        if (mapped == null) {
            log.debug("No mapping for subject '{}' in dataset '{}', skipping", subject, datasetName);
            return null;
        }

        return mapped;
    }

    public boolean isValidSystemSubject(String subject) {
        return subject != null && SYSTEM_SUBJECTS.contains(subject.trim());
    }
}

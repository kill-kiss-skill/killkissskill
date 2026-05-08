package com.school.itas.rag.splitter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class TextSplitter {

    @Value("${itas.rag.chunk-size:512}")
    private int chunkSize;

    @Value("${itas.rag.chunk-overlap:50}")
    private int chunkOverlap;

    public List<String> split(String text) {
        List<String> chunks = new ArrayList<>();
        if (text == null || text.isBlank()) return chunks;

        String cleaned = text.replaceAll("\\s+", " ").trim();
        int start = 0;
        while (start < cleaned.length()) {
            int end = Math.min(start + chunkSize, cleaned.length());
            chunks.add(cleaned.substring(start, end));
            start += chunkSize - chunkOverlap;
        }
        return chunks;
    }
}

package com.school.itas.rag.parser;

import com.school.itas.common.exception.BusinessException;
import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

@Component
public class DocumentParser {

    private final Tika tika = new Tika();

    public String parse(MultipartFile file) {
        try (InputStream is = file.getInputStream()) {
            return tika.parseToString(is);
        } catch (Exception e) {
            throw new BusinessException("文档解析失败: " + e.getMessage());
        }
    }

    public String parse(InputStream is) {
        try {
            return tika.parseToString(is);
        } catch (Exception e) {
            throw new BusinessException("文档解析失败: " + e.getMessage());
        }
    }
}

package com.school.itas.service;

import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.model.req.KnowledgeDocReq;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface KnowledgeService {

    KnowledgeDocument uploadDocument(Long uploaderId, KnowledgeDocReq req, MultipartFile file);

    List<KnowledgeDocument> listDocuments(String subject, String keyword, Integer page, Integer size);

    void deleteDocument(Long docId);

    void updateDocument(Long docId, String title, String subject);

    void vectorizeDocument(Long docId);
}

package com.school.itas.service;

import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.entity.KnowledgeImportTask;
import com.school.itas.model.req.KnowledgeDocReq;
import com.school.itas.model.resp.ImportProgressResp;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;

public interface KnowledgeService {

    KnowledgeDocument uploadDocument(Long uploaderId, KnowledgeDocReq req, MultipartFile file);

    List<KnowledgeDocument> listDocuments(String subject, String keyword, Integer page, Integer size);

    void deleteDocument(Long docId);

    void updateDocument(Long docId, String title, String subject);

    void vectorizeDocument(Long docId);

    ImportProgressResp batchImport(InputStream jsonlStream, String datasetName, String subjectFilter, Long operatorId);

    ImportProgressResp getImportTask(String batchNo);

    List<KnowledgeImportTask> listImportTasks(int page, int size);
}

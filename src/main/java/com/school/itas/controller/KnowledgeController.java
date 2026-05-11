package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.entity.KnowledgeDocument;
import com.school.itas.model.req.KnowledgeDocReq;
import com.school.itas.service.KnowledgeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Tag(name = "知识库管理")
@RestController
@RequestMapping("/api/knowledge")
@RequiredArgsConstructor
public class KnowledgeController {

    private final KnowledgeService knowledgeService;

    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    @Operation(summary = "上传文档并向量化")
    @PostMapping("/upload")
    public Result<KnowledgeDocument> upload(
            @RequestParam String title,
            @RequestParam String subject,
            @RequestParam MultipartFile file,
            Authentication auth) {
        Long uploaderId = (Long) auth.getPrincipal();
        KnowledgeDocReq req = new KnowledgeDocReq();
        req.setTitle(title);
        req.setSubject(subject);
        return Result.ok(knowledgeService.uploadDocument(uploaderId, req, file));
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "知识库文档列表")
    @GetMapping("/list")
    public Result<List<KnowledgeDocument>> list(
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size) {
        return Result.ok(knowledgeService.listDocuments(subject, keyword, page, size));
    }

    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    @Operation(summary = "编辑文档信息")
    @PutMapping("/{docId}")
    public Result<Void> update(@PathVariable Long docId,
                               @RequestParam(required = false) String title,
                               @RequestParam(required = false) String subject) {
        knowledgeService.updateDocument(docId, title, subject);
        return Result.ok();
    }

    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    @Operation(summary = "删除文档")
    @DeleteMapping("/{docId}")
    public Result<Void> delete(@PathVariable Long docId) {
        knowledgeService.deleteDocument(docId);
        return Result.ok();
    }

    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    @Operation(summary = "重新向量化文档")
    @PostMapping("/{docId}/vectorize")
    public Result<Void> vectorize(@PathVariable Long docId) {
        knowledgeService.vectorizeDocument(docId);
        return Result.ok();
    }
}

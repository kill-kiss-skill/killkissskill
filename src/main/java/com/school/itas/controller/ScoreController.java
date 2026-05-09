package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.req.ScoreReq;
import com.school.itas.model.resp.ScoreAnalysisResp;
import com.school.itas.model.resp.ScoreResp;
import com.school.itas.service.LearningService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Tag(name = "成绩管理")
@RestController
@RequestMapping("/api/score")
@RequiredArgsConstructor
public class ScoreController {

    private final LearningService learningService;

    @Operation(summary = "录入成绩")
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<Void> save(@Valid @RequestBody ScoreReq req, Authentication auth) {
        learningService.saveScore(req, (Long) auth.getPrincipal());
        return Result.ok();
    }

    @Operation(summary = "Excel批量导入成绩")
    @PostMapping("/import")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<String> importScores(
            @RequestParam MultipartFile file,
            @RequestParam Long courseId,
            @RequestParam String semester,
            Authentication auth) {
        return Result.ok(learningService.importScores(file, courseId, semester, (Long) auth.getPrincipal()));
    }

    @Operation(summary = "更新成绩")
    @PutMapping("/{scoreId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<Void> update(@PathVariable Long scoreId, @Valid @RequestBody ScoreReq req) {
        learningService.updateScore(scoreId, req);
        return Result.ok();
    }

    @Operation(summary = "删除成绩")
    @DeleteMapping("/{scoreId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<Void> delete(@PathVariable Long scoreId) {
        learningService.deleteScore(scoreId);
        return Result.ok();
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "查询学生成绩")
    @GetMapping("/student/{studentId}")
    public Result<List<ScoreResp>> studentScores(
            @PathVariable Long studentId,
            @RequestParam(required = false) String semester) {
        return Result.ok(learningService.getStudentScores(studentId, semester));
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "AI成绩分析")
    @GetMapping("/analyze/{studentId}")
    public Result<ScoreAnalysisResp> analyze(@PathVariable Long studentId) {
        return Result.ok(learningService.analyzeScore(studentId));
    }
}

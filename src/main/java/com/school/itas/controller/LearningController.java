package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.entity.LearningPlan;
import com.school.itas.model.req.ScoreReq;
import com.school.itas.model.resp.LearningPlanResp;
import com.school.itas.model.resp.ScoreAnalysisResp;
import com.school.itas.model.resp.ScoreResp;
import com.school.itas.service.LearningService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Tag(name = "学习与成绩")
@RestController
@RequestMapping("/api/learning")
@RequiredArgsConstructor
public class LearningController {

    private final LearningService learningService;

    @Operation(summary = "获取学生成绩列表")
    @GetMapping("/scores")
    public Result<List<ScoreResp>> scores(
            @RequestParam Long studentId,
            @RequestParam(required = false) String semester) {
        return Result.ok(learningService.getStudentScores(studentId, semester));
    }

    @Operation(summary = "成绩分析（AI）")
    @GetMapping("/analyze")
    public Result<ScoreAnalysisResp> analyze(@RequestParam Long studentId) {
        return Result.ok(learningService.analyzeScore(studentId));
    }

    @Operation(summary = "生成个性化学习计划（AI）")
    @PostMapping("/plan/generate")
    public Result<LearningPlan> generatePlan(@RequestParam Long studentId) {
        return Result.ok(learningService.generatePlan(studentId));
    }

    @Operation(summary = "获取学习计划列表")
    @GetMapping("/plans")
    public Result<List<LearningPlanResp>> plans(@RequestParam Long studentId) {
        return Result.ok(learningService.getPlans(studentId));
    }

    @Operation(summary = "切换学习计划任务项完成状态")
    @PutMapping("/plan/item/{itemId}/toggle")
    public Result<Void> togglePlanItem(@PathVariable Long itemId) {
        learningService.togglePlanItem(itemId);
        return Result.ok();
    }

    @Operation(summary = "录入成绩（教师）")
    @PostMapping("/score")
    public Result<Void> saveScore(@Valid @RequestBody ScoreReq req, Authentication auth) {
        Long operatorId = (Long) auth.getPrincipal();
        learningService.saveScore(req, operatorId);
        return Result.ok();
    }

    @Operation(summary = "Excel批量导入成绩（教师）")
    @PostMapping("/score/import")
    public Result<String> importScores(
            @RequestParam MultipartFile file,
            @RequestParam Long courseId,
            @RequestParam String semester,
            Authentication auth) {
        Long operatorId = (Long) auth.getPrincipal();
        String batchNo = learningService.importScores(file, courseId, semester, operatorId);
        return Result.ok(batchNo);
    }
}

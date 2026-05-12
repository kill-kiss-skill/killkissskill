package com.school.itas.service;

import com.school.itas.entity.LearningPlan;
import com.school.itas.model.req.ScoreReq;
import com.school.itas.model.resp.ImportResultResp;
import com.school.itas.model.resp.LearningPlanResp;
import com.school.itas.model.resp.ScoreAnalysisResp;
import com.school.itas.model.resp.ScoreResp;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface LearningService {

    List<ScoreResp> getStudentScores(Long studentId, String semester);

    /** 教师端查询学生成绩，studentInfoId 为 student_info.id，不做 sys_user 映射 */
    List<ScoreResp> getStudentScoresByStudentInfoId(Long studentInfoId, String semester);

    ScoreAnalysisResp analyzeScore(Long studentId);

    LearningPlan generatePlan(Long studentId);

    List<LearningPlanResp> getPlans(Long studentId);

    void togglePlanItem(Long itemId);

    void saveScore(ScoreReq req, Long operatorId);

    void updateScore(Long scoreId, ScoreReq req);

    void deleteScore(Long scoreId);

    ImportResultResp importScores(MultipartFile file, Long courseId, String semester, Long operatorId);

    byte[] generateTemplate();
}

package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.agent.LearningAnalyzeAgent;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.common.utils.ExcelUtil;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.model.req.ScoreReq;
import com.school.itas.model.resp.LearningPlanResp;
import com.school.itas.model.resp.ScoreAnalysisResp;
import com.school.itas.model.resp.ScoreResp;
import com.school.itas.service.LearningService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@Service
@RequiredArgsConstructor
public class LearningServiceImpl implements LearningService {

    private final ScoreMapper scoreMapper;
    private final ScoreImportBatchMapper batchMapper;
    private final StudentInfoMapper studentInfoMapper;
    private final SysUserMapper userMapper;
    private final LearningPlanMapper planMapper;
    private final LearningPlanItemMapper planItemMapper;
    private final LearningAnalyzeAgent analyzeAgent;

    @Override
    public List<ScoreResp> getStudentScores(Long studentId, String semester) {
        // studentId is sys_user.id from frontend; resolve to student_info.id for score queries
        StudentInfo si = studentInfoMapper.selectOne(
                new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, studentId));
        Long scoreStudentId = si != null ? si.getId() : studentId;
        List<Map<String, Object>> details = scoreMapper.selectScoreDetailByStudent(scoreStudentId, semester);
        return details.stream().map(row -> {
            ScoreResp r = new ScoreResp();
            r.setId(toLong(row.get("id")));
            r.setCourseName(str(row.get("course_name")));
            r.setSubject(str(row.get("subject")));
            r.setUsualScore(toDecimal(row.get("usual_score")));
            r.setMidScore(toDecimal(row.get("mid_score")));
            r.setFinalScore(toDecimal(row.get("final_score")));
            r.setTotalScore(toDecimal(row.get("total_score")));
            r.setGradeLevel(str(row.get("grade_level")));
            r.setIsPass(toInt(row.get("is_pass")));
            r.setSemester(str(row.get("semester")));
            return r;
        }).toList();
    }

    @Override
    public ScoreAnalysisResp analyzeScore(Long studentId) {
        // studentId here is sys_user.id — look up student_info by userId
        StudentInfo si = studentInfoMapper.selectOne(
                new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, studentId));
        SysUser user = userMapper.selectById(studentId);
        String studentName = user != null ? user.getRealName() : "学生";

        // Use student_info.id for score queries if found, otherwise fall back to studentId
        Long scoreStudentId = si != null ? si.getId() : studentId;

        List<Map<String, Object>> avgList = scoreMapper.selectAvgScoreBySubject(scoreStudentId);
        List<String> weakSubjects = new ArrayList<>();
        List<ScoreAnalysisResp.SubjectAvg> subjectAvgs = new ArrayList<>();

        for (Map<String, Object> row : avgList) {
            String subject = str(row.get("subject"));
            BigDecimal avg = toDecimal(row.get("avgScore"));
            ScoreAnalysisResp.SubjectAvg sa = new ScoreAnalysisResp.SubjectAvg();
            sa.setSubject(subject);
            sa.setAvgScore(avg);
            sa.setGradeLevel(calcGradeLevel(avg));
            subjectAvgs.add(sa);
            if (avg != null && avg.compareTo(BigDecimal.valueOf(60)) < 0) {
                weakSubjects.add(subject);
            }
        }

        List<Map<String, Object>> scoreData = scoreMapper.selectScoreDetailByStudent(scoreStudentId, null);
        String analysisText = analyzeAgent.analyze(studentName, scoreData);

        ScoreAnalysisResp resp = new ScoreAnalysisResp();
        resp.setStudentId(studentId);
        resp.setStudentName(studentName);
        resp.setSubjectAvgList(subjectAvgs);
        resp.setWeakSubjects(weakSubjects);
        resp.setAnalysisText(analysisText);
        return resp;
    }

    @Override
    @Transactional
    public LearningPlan generatePlan(Long studentId) {
        ScoreAnalysisResp analysis = analyzeScore(studentId);

        LearningPlan plan = new LearningPlan();
        plan.setStudentId(studentId);
        plan.setPlanTitle("个性化学习计划 - " + analysis.getStudentName());
        plan.setContent(analysis.getAnalysisText());
        plan.setWeakSubjects(String.join(",", analysis.getWeakSubjects()));
        plan.setGeneratedBy("AI");
        plan.setStatus(1);
        planMapper.insert(plan);
        // 从AI生成的内容中解析任务项并创建
        String[] lines = plan.getContent().split("\n");
        int priority = 1;
        for (String line : lines) {
            line = line.trim();
            if ((line.startsWith("- ") || line.matches("^\\d+\\.\\s+.*")) && line.length() > 5 && line.length() < 200) {
                String task = line.replaceAll("^[-\\d\\.]+\\s+", "").trim();
                LearningPlanItem item = new LearningPlanItem();
                item.setPlanId(plan.getId());
                item.setTaskDesc(task);
                item.setPriority(Math.min(priority, 5));
                item.setStatus(0);
                item.setSubject(analysis.getWeakSubjects().isEmpty() ? "通用" : analysis.getWeakSubjects().get(0));
                planItemMapper.insert(item);
                priority++;
            }
        }
        return plan;
    }

    @Override
    public List<LearningPlanResp> getPlans(Long studentId) {
        List<LearningPlan> plans = planMapper.selectList(
                new LambdaQueryWrapper<LearningPlan>()
                        .eq(LearningPlan::getStudentId, studentId)
                        .orderByDesc(LearningPlan::getCreatedAt));
        return plans.stream().map(plan -> {
            LearningPlanResp resp = new LearningPlanResp();
            resp.setId(plan.getId());
            resp.setStudentId(plan.getStudentId());
            resp.setPlanTitle(plan.getPlanTitle());
            resp.setContent(plan.getContent());
            resp.setWeakSubjects(plan.getWeakSubjects());
            resp.setSemester(plan.getSemester());
            resp.setGeneratedBy(plan.getGeneratedBy());
            resp.setStatus(plan.getStatus());
            resp.setCreatedAt(plan.getCreatedAt());
            List<LearningPlanItem> items = planItemMapper.selectList(
                    new LambdaQueryWrapper<LearningPlanItem>()
                            .eq(LearningPlanItem::getPlanId, plan.getId())
                            .orderByAsc(LearningPlanItem::getPriority));
            resp.setItems(items.stream().map(item -> {
                LearningPlanResp.PlanItemResp ir = new LearningPlanResp.PlanItemResp();
                ir.setId(item.getId());
                ir.setSubject(item.getSubject());
                ir.setTaskDesc(item.getTaskDesc());
                ir.setResourceUrl(item.getResourceUrl());
                ir.setPriority(item.getPriority());
                ir.setStatus(item.getStatus());
                ir.setDueDate(item.getDueDate());
                return ir;
            }).toList());
            return resp;
        }).toList();
    }

    @Override
    public void togglePlanItem(Long itemId) {
        LearningPlanItem item = planItemMapper.selectById(itemId);
        if (item != null) {
            item.setStatus(item.getStatus() == 1 ? 0 : 1);
            planItemMapper.updateById(item);
        }
    }

    @Override
    @Transactional
    public void saveScore(ScoreReq req, Long operatorId) {
        BigDecimal total = calcTotal(req.getUsualScore(), req.getMidScore(), req.getFinalScore());
        // 检查重复
        long existing = scoreMapper.selectCount(new LambdaQueryWrapper<Score>()
                .eq(Score::getStudentId, req.getStudentId())
                .eq(Score::getCourseId, req.getCourseId())
                .eq(Score::getSemester, req.getSemester()));
        if (existing > 0) {
            throw new BusinessException(400, "该学生在本学期此课程已有成绩记录");
        }
        Score score = new Score();
        score.setStudentId(req.getStudentId());
        score.setCourseId(req.getCourseId());
        score.setUsualScore(req.getUsualScore());
        score.setMidScore(req.getMidScore());
        score.setFinalScore(req.getFinalScore());
        score.setTotalScore(total);
        score.setGradeLevel(calcGradeLevel(total));
        score.setIsPass(total != null && total.compareTo(BigDecimal.valueOf(60)) >= 0 ? 1 : 0);
        score.setSemester(req.getSemester());
        score.setRemark(req.getRemark());
        score.setCreatedBy(operatorId);
        scoreMapper.insert(score);
    }

    @Override
    @Transactional
    public String importScores(MultipartFile file, Long courseId, String semester, Long operatorId) {
        String batchNo = UUID.randomUUID().toString().replace("-", "");
        ScoreImportBatch batch = new ScoreImportBatch();
        batch.setBatchNo(batchNo);
        batch.setFileName(file.getOriginalFilename());
        batch.setCourseId(courseId);
        batch.setSemester(semester);
        batch.setOperatorId(operatorId);
        batch.setStatus(0);
        batchMapper.insert(batch);

        List<ScoreReq> rows = ExcelUtil.readExcel(file, row -> {
            String studentNo = ExcelUtil.getCellString(row, 0);
            if (studentNo == null) return null;
            StudentInfo si = studentInfoMapper.selectOne(
                    new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getStudentNo, studentNo));
            if (si == null) return null;
            ScoreReq req = new ScoreReq();
            req.setStudentId(si.getId());
            req.setCourseId(courseId);
            req.setUsualScore(ExcelUtil.getCellDecimal(row, 1));
            req.setMidScore(ExcelUtil.getCellDecimal(row, 2));
            req.setFinalScore(ExcelUtil.getCellDecimal(row, 3));
            req.setSemester(semester);
            return req;
        });

        int success = 0, fail = 0;
        for (ScoreReq req : rows) {
            try {
                saveScore(req, operatorId);
                success++;
            } catch (Exception e) {
                fail++;
            }
        }

        batch.setTotalRows(rows.size());
        batch.setSuccessRows(success);
        batch.setFailRows(fail);
        batch.setStatus(1);
        batchMapper.updateById(batch);

        return batchNo;
    }

    @Override
    public void updateScore(Long scoreId, ScoreReq req) {
        Score score = scoreMapper.selectById(scoreId);
        if (score == null) throw new BusinessException(404, "成绩记录不存在");
        BigDecimal total = calcTotal(req.getUsualScore(), req.getMidScore(), req.getFinalScore());
        score.setUsualScore(req.getUsualScore());
        score.setMidScore(req.getMidScore());
        score.setFinalScore(req.getFinalScore());
        score.setTotalScore(total);
        score.setGradeLevel(calcGradeLevel(total));
        score.setIsPass(total != null && total.compareTo(BigDecimal.valueOf(60)) >= 0 ? 1 : 0);
        score.setSemester(req.getSemester());
        score.setRemark(req.getRemark());
        scoreMapper.updateById(score);
    }

    @Override
    @Transactional
    public void deleteScore(Long scoreId) {
        Score score = scoreMapper.selectById(scoreId);
        if (score == null) throw new BusinessException(404, "成绩记录不存在");
        scoreMapper.deleteById(scoreId);
    }

    private BigDecimal calcTotal(BigDecimal usual, BigDecimal mid, BigDecimal fin) {
        if (fin == null) return null;
        BigDecimal u = usual != null ? usual : BigDecimal.ZERO;
        BigDecimal m = mid != null ? mid : BigDecimal.ZERO;
        return u.multiply(BigDecimal.valueOf(0.3))
                .add(m.multiply(BigDecimal.valueOf(0.2)))
                .add(fin.multiply(BigDecimal.valueOf(0.5)))
                .setScale(1, RoundingMode.HALF_UP);
    }

    private String calcGradeLevel(BigDecimal score) {
        if (score == null) return null;
        double v = score.doubleValue();
        if (v >= 90) return "A";
        if (v >= 80) return "B";
        if (v >= 70) return "C";
        if (v >= 60) return "D";
        return "F";
    }

    private String str(Object o) { return o != null ? o.toString() : null; }
    private Long toLong(Object o) { return o != null ? Long.valueOf(o.toString()) : null; }
    private Integer toInt(Object o) { return o != null ? Integer.valueOf(o.toString()) : null; }
    private BigDecimal toDecimal(Object o) {
        if (o == null) return null;
        try { return new BigDecimal(o.toString()); } catch (Exception e) { return null; }
    }
}

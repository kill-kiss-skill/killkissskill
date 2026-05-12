package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.agent.LearningAnalyzeAgent;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.common.utils.ExcelUtil;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.model.req.ScoreReq;
import com.school.itas.model.resp.ImportResultResp;
import com.school.itas.model.resp.LearningPlanResp;
import com.school.itas.model.resp.ScoreAnalysisResp;
import com.school.itas.model.resp.ScoreResp;
import com.school.itas.service.LearningService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
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
    private final CourseMapper courseMapper;
    private final LearningAnalyzeAgent analyzeAgent;

    @Override
    public List<ScoreResp> getStudentScores(Long studentId, String semester) {
        StudentInfo si = studentInfoMapper.selectOne(
                new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, studentId));
        Long scoreStudentId = si != null ? si.getId() : studentId;
        return mapScoreDetails(scoreMapper.selectScoreDetailByStudent(scoreStudentId, semester));
    }

    @Override
    public List<ScoreResp> getStudentScoresByStudentInfoId(Long studentInfoId, String semester) {
        return mapScoreDetails(scoreMapper.selectScoreDetailByStudent(studentInfoId, semester));
    }

    private List<ScoreResp> mapScoreDetails(List<Map<String, Object>> details) {
        return details.stream().map(row -> {
            ScoreResp r = new ScoreResp();
            r.setId(toLong(row.get("id")));
            r.setStudentName(str(row.get("student_name")));
            r.setStudentNo(str(row.get("student_no")));
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
        // 校验教师是否有权为该课程录入成绩
        Course course = courseMapper.selectById(req.getCourseId());
        if (course == null) {
            throw new BusinessException(400, "课程不存在");
        }
        if (!operatorId.equals(course.getTeacherId())) {
            throw new BusinessException(403, "您只能为自己教授的课程录入成绩");
        }
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
    public ImportResultResp importScores(MultipartFile file, Long courseId, String semester, Long operatorId) {
        String batchNo = UUID.randomUUID().toString().replace("-", "");
        ScoreImportBatch batch = new ScoreImportBatch();
        batch.setBatchNo(batchNo);
        batch.setFileName(file.getOriginalFilename());
        batch.setCourseId(courseId);
        batch.setSemester(semester);
        batch.setOperatorId(operatorId);
        batch.setStatus(0);
        batchMapper.insert(batch);

        List<ScoreReq> rows = new ArrayList<>();
        List<ImportResultResp.ImportError> parseErrors = new ArrayList<>();

        // 解析整个 Excel 文件（含表头）
        List<org.apache.poi.ss.usermodel.Row> allRows;
        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);
            allRows = new ArrayList<>();
            for (int i = 0; i <= sheet.getLastRowNum(); i++) {
                org.apache.poi.ss.usermodel.Row row = sheet.getRow(i);
                if (row != null) allRows.add(row);
            }
        } catch (Exception e) {
            parseErrors.add(new ImportResultResp.ImportError(0, "文件解析失败: " + e.getMessage()));
            return buildImportResult(batch, batchNo, 0, parseErrors);
        }

        if (allRows.isEmpty()) {
            parseErrors.add(new ImportResultResp.ImportError(0, "文件为空或无法读取"));
            return buildImportResult(batch, batchNo, 0, parseErrors);
        }

        // 解析表头，建立列名→列索引映射
        org.apache.poi.ss.usermodel.Row headerRow = allRows.get(0);
        Map<String, Integer> colMap = new LinkedHashMap<>();
        for (int c = 0; c < headerRow.getLastCellNum(); c++) {
            String h = ExcelUtil.getCellString(headerRow, c);
            if (h != null) colMap.put(h.trim(), c);
        }

        // 校验必要列
        if (!colMap.containsKey("学号") && !colMap.containsKey("期末分")) {
            parseErrors.add(new ImportResultResp.ImportError(0,
                "表头缺少必要列，需要包含：学号、期末分，可选：姓名、平时分、期中分。" +
                "当前表头：" + String.join("、", colMap.keySet())));
            return buildImportResult(batch, batchNo, 0, parseErrors);
        }

        // 如果表头不含"学号"则无法继续
        Integer colStudentNo = colMap.get("学号");
        Integer colStudentName = colMap.get("姓名");
        Integer colUsual = colMap.get("平时分");
        Integer colMid = colMap.get("期中分");
        Integer colFinal = colMap.get("期末分");

        for (int i = 1; i < allRows.size(); i++) {
            org.apache.poi.ss.usermodel.Row row = allRows.get(i);
            int excelRow = i + 1; // Excel行号（第1行是表头）

            String studentNo = colStudentNo != null ? ExcelUtil.getCellString(row, colStudentNo) : null;
            String studentName = colStudentName != null ? ExcelUtil.getCellString(row, colStudentName) : null;
            if (studentNo == null && studentName == null) continue;

            // 先按学号查找，失败则按姓名查找
            StudentInfo si = null;
            if (studentNo != null) {
                si = studentInfoMapper.selectOne(
                        new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getStudentNo, studentNo));
            }
            if (si == null && studentName != null) {
                List<SysUser> byName = userMapper.selectList(
                        new LambdaQueryWrapper<SysUser>().eq(SysUser::getRealName, studentName));
                if (byName.size() == 1) {
                    si = studentInfoMapper.selectOne(
                            new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, byName.get(0).getId()));
                } else if (byName.size() > 1) {
                    parseErrors.add(new ImportResultResp.ImportError(excelRow, "姓名\"" + studentName + "\"匹配到多个学生，请使用学号"));
                    continue;
                }
            }
            if (si == null) {
                parseErrors.add(new ImportResultResp.ImportError(excelRow, "未找到学生（学号:" + studentNo + " 姓名:" + studentName + "）"));
                continue;
            }

            ScoreReq req = new ScoreReq();
            req.setStudentId(si.getId());
            req.setCourseId(courseId);
            req.setUsualScore(colUsual != null ? ExcelUtil.getCellDecimal(row, colUsual) : null);
            req.setMidScore(colMid != null ? ExcelUtil.getCellDecimal(row, colMid) : null);
            req.setFinalScore(colFinal != null ? ExcelUtil.getCellDecimal(row, colFinal) : null);
            req.setSemester(semester);
            rows.add(req);
        }

        return buildImportResult(batch, batchNo, rows.size(), parseErrors, rows, operatorId);
    }

    private ImportResultResp buildImportResult(ScoreImportBatch batch, String batchNo,
                                                int totalCount, List<ImportResultResp.ImportError> parseErrors) {
        return buildImportResult(batch, batchNo, totalCount, parseErrors, List.of(), null);
    }

    private ImportResultResp buildImportResult(ScoreImportBatch batch, String batchNo,
                                                int totalRows, List<ImportResultResp.ImportError> parseErrors,
                                                List<ScoreReq> rows, Long operatorId) {
        ImportResultResp result = new ImportResultResp();
        result.setBatchNo(batchNo);
        result.setTotalRows(totalRows + parseErrors.size());
        int success = 0, fail = 0;
        List<ImportResultResp.ImportError> allErrors = new ArrayList<>(parseErrors);

        if (operatorId != null) {
            for (int i = 0; i < rows.size(); i++) {
                ScoreReq req = rows.get(i);
                try {
                    saveScore(req, operatorId);
                    success++;
                } catch (Exception e) {
                    fail++;
                    allErrors.add(new ImportResultResp.ImportError(i + 2, e.getMessage()));
                }
            }
        }

        result.setSuccessRows(success);
        result.setFailRows(fail);
        result.setErrors(allErrors);

        batch.setTotalRows(result.getTotalRows());
        batch.setSuccessRows(success);
        batch.setFailRows(fail);
        batch.setStatus(1);
        batchMapper.updateById(batch);

        return result;
    }

    @Override
    public byte[] generateTemplate() {
        try (XSSFWorkbook workbook = new XSSFWorkbook(); ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("成绩导入模板");
            // 表头样式
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 11);
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            // 表头行
            String[] headers = {"学号", "姓名", "平时分", "期中分", "期末分"};
            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
                sheet.setColumnWidth(i, 16 * 256); // 约16字符宽
            }

            // 示例数据行
            String[][] examples = {
                {"202207034221", "张三", "85", "78", "82"},
                {"202407034101", "李四", "90", "88", "95"},
            };
            for (int r = 0; r < examples.length; r++) {
                Row row = sheet.createRow(r + 1);
                for (int c = 0; c < examples[r].length; c++) {
                    row.createCell(c).setCellValue(examples[r][c]);
                }
            }

            workbook.write(bos);
            return bos.toByteArray();
        } catch (Exception e) {
            throw new BusinessException("生成模板失败: " + e.getMessage());
        }
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

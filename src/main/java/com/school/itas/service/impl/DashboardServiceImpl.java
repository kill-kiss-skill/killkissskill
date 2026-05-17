package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.model.resp.AdminDashboardResp;
import com.school.itas.model.resp.StudentDashboardResp;
import com.school.itas.model.resp.TeacherCourseResp;
import com.school.itas.model.resp.TeacherDashboardResp;
import com.school.itas.model.resp.TeacherStudentResp;
import com.school.itas.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final ScoreMapper scoreMapper;
    private final SysUserMapper userMapper;
    private final StudentInfoMapper studentInfoMapper;
    private final TeacherInfoMapper teacherInfoMapper;
    private final CourseMapper courseMapper;
    private final LearningPlanMapper planMapper;
    private final KnowledgeDocumentMapper docMapper;
    private final SysClassMapper classMapper;
    private final SysLogMapper logMapper;

    @Override
    public List<TeacherStudentResp> getTeacherStudents(Long userId, String keyword) {
        List<Course> courses = courseMapper.selectList(
                new LambdaQueryWrapper<Course>().eq(Course::getTeacherId, userId));
        List<Long> courseIds = courses.stream().map(Course::getId).toList();
        if (courseIds.isEmpty()) return List.of();

        List<Score> scores = scoreMapper.selectList(
                new LambdaQueryWrapper<Score>().in(Score::getCourseId, courseIds));
        Map<Long, List<Score>> byStudent = scores.stream()
                .collect(Collectors.groupingBy(Score::getStudentId));

        Set<Long> studentIds = byStudent.keySet();
        List<StudentInfo> studentInfos = studentInfoMapper.selectBatchIds(new ArrayList<>(studentIds));
        Map<Long, StudentInfo> siMap = studentInfos.stream()
                .collect(Collectors.toMap(StudentInfo::getId, Function.identity()));

        Set<Long> userIds = studentInfos.stream().map(StudentInfo::getUserId).collect(Collectors.toSet());
        List<SysUser> users = userMapper.selectBatchIds(new ArrayList<>(userIds));
        Map<Long, SysUser> userMap = users.stream()
                .collect(Collectors.toMap(SysUser::getId, Function.identity()));

        Set<Long> classIds = studentInfos.stream().map(StudentInfo::getClassId).filter(Objects::nonNull).collect(Collectors.toSet());
        List<SysClass> classes = classIds.isEmpty() ? List.of() : classMapper.selectBatchIds(new ArrayList<>(classIds));
        Map<Long, SysClass> classMap = classes.stream()
                .collect(Collectors.toMap(SysClass::getId, Function.identity()));

        String kw = keyword != null ? keyword.trim().toLowerCase() : null;
        return byStudent.entrySet().stream().map(entry -> {
            Long sid = entry.getKey();
            List<Score> scoreList = entry.getValue();
            double avg = scoreList.stream().mapToDouble(s ->
                    s.getTotalScore() != null ? s.getTotalScore().doubleValue() : 0).average().orElse(0);

            StudentInfo si = siMap.get(sid);
            SysUser user = si != null ? userMap.get(si.getUserId()) : null;
            SysClass cls = si != null && si.getClassId() != null ? classMap.get(si.getClassId()) : null;

            TeacherStudentResp r = new TeacherStudentResp();
            r.setStudentId(sid);
            r.setStudentNo(si != null ? si.getStudentNo() : "");
            r.setStudentName(user != null ? user.getRealName() : "未知");
            r.setClassName(cls != null ? cls.getClassName() : "");
            r.setAvgScore(BigDecimal.valueOf(Math.round(avg * 10) / 10.0));
            r.setScoreCount(scoreList.size());
            return r;
        }).filter(r -> {
            if (kw == null || kw.isEmpty()) return true;
            return (r.getStudentNo() != null && r.getStudentNo().toLowerCase().contains(kw))
                || (r.getStudentName() != null && r.getStudentName().toLowerCase().contains(kw));
        }).toList();
    }

    @Override
    public List<TeacherCourseResp> getTeacherCourses(Long userId) {
        List<Course> courses = courseMapper.selectList(
                new LambdaQueryWrapper<Course>().eq(Course::getTeacherId, userId));
        return courses.stream().map(c -> {
            TeacherCourseResp r = new TeacherCourseResp();
            r.setId(c.getId());
            r.setCourseName(c.getCourseName());
            r.setSubject(c.getSubject());
            r.setSemester(c.getSemester());
            return r;
        }).toList();
    }

    @Override
    public StudentDashboardResp getStudentDashboard(Long userId) {
        StudentInfo si = studentInfoMapper.selectOne(
                new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, userId));
        Long scoreStudentId = si != null ? si.getId() : userId;

        List<Score> scores = scoreMapper.selectList(
                new LambdaQueryWrapper<Score>().eq(Score::getStudentId, scoreStudentId));

        StudentDashboardResp resp = new StudentDashboardResp();
        resp.setTotalScores(scores.size());
        resp.setPassCount((int) scores.stream().filter(s -> s.getIsPass() == 1).count());
        resp.setFailCount((int) scores.stream().filter(s -> s.getIsPass() == 0).count());

        Long planCount = planMapper.selectCount(
                new LambdaQueryWrapper<LearningPlan>().eq(LearningPlan::getStudentId, userId));
        resp.setPlanCount(planCount.intValue());

        // 批量加载课程信息
        Set<Long> courseIds = scores.stream().map(Score::getCourseId).collect(Collectors.toSet());
        Map<Long, Course> courseMap = courseMapper.selectBatchIds(new ArrayList<>(courseIds))
                .stream().collect(Collectors.toMap(Course::getId, Function.identity()));

        Map<String, List<Score>> bySubject = scores.stream()
                .filter(s -> courseMap.containsKey(s.getCourseId()))
                .collect(Collectors.groupingBy(s -> {
                    Course c = courseMap.get(s.getCourseId());
                    return c.getSubject();
                }));
        List<StudentDashboardResp.SubjectAvg> subjectAvgs = new ArrayList<>();
        for (Map.Entry<String, List<Score>> entry : bySubject.entrySet()) {
            StudentDashboardResp.SubjectAvg sa = new StudentDashboardResp.SubjectAvg();
            sa.setSubject(entry.getKey());
            BigDecimal avg = entry.getValue().stream()
                    .map(Score::getTotalScore)
                    .filter(Objects::nonNull)
                    .collect(Collectors.collectingAndThen(
                            Collectors.averagingDouble(BigDecimal::doubleValue),
                            v -> BigDecimal.valueOf(v).setScale(1, RoundingMode.HALF_UP)));
            sa.setAvgScore(avg);
            sa.setGradeLevel(calcGradeLevel(avg));
            subjectAvgs.add(sa);
        }
        // 确保6门固定学科都存在，无数据的填0
        List<String> allSubjects = List.of("数据结构", "操作系统", "计算机网络", "数据库", "算法", "Java程序设计");
        for (String subj : allSubjects) {
            boolean exists = subjectAvgs.stream().anyMatch(sa -> subj.equals(sa.getSubject()));
            if (!exists) {
                StudentDashboardResp.SubjectAvg sa = new StudentDashboardResp.SubjectAvg();
                sa.setSubject(subj);
                sa.setAvgScore(BigDecimal.ZERO);
                sa.setGradeLevel(null);
                subjectAvgs.add(sa);
            }
        }
        resp.setSubjectAvgs(subjectAvgs);

        Map<String, Integer> gradeDist = new LinkedHashMap<>();
        for (String g : List.of("A", "B", "C", "D", "F")) gradeDist.put(g, 0);
        for (Score s : scores) {
            if (s.getGradeLevel() != null) {
                gradeDist.merge(s.getGradeLevel(), 1, Integer::sum);
            }
        }
        resp.setGradeDistribution(gradeDist);

        Map<String, List<Score>> bySemester = scores.stream()
                .collect(Collectors.groupingBy(s -> s.getSemester() != null ? s.getSemester() : "未知",
                        LinkedHashMap::new, Collectors.toList()));
        List<StudentDashboardResp.SemesterTrend> trends = new ArrayList<>();
        for (Map.Entry<String, List<Score>> entry : bySemester.entrySet()) {
            StudentDashboardResp.SemesterTrend t = new StudentDashboardResp.SemesterTrend();
            t.setSemester(entry.getKey());
            t.setAvgScore(entry.getValue().stream()
                    .map(Score::getTotalScore)
                    .filter(Objects::nonNull)
                    .collect(Collectors.collectingAndThen(
                            Collectors.averagingDouble(BigDecimal::doubleValue),
                            v -> BigDecimal.valueOf(v).setScale(1, RoundingMode.HALF_UP))));
            trends.add(t);
        }
        resp.setSemesterTrends(trends);

        return resp;
    }

    @Override
    public TeacherDashboardResp getTeacherDashboard(Long userId) {
        List<Course> courses = courseMapper.selectList(
                new LambdaQueryWrapper<Course>().eq(Course::getTeacherId, userId));
        List<Long> courseIds = courses.stream().map(Course::getId).toList();

        List<Score> scores;
        if (courseIds.isEmpty()) {
            scores = List.of();
        } else {
            scores = scoreMapper.selectList(
                    new LambdaQueryWrapper<Score>().in(Score::getCourseId, courseIds));
        }

        TeacherDashboardResp resp = new TeacherDashboardResp();
        resp.setTotalCourses(courses.size());

        Set<Long> studentIds = scores.stream().map(Score::getStudentId).collect(Collectors.toSet());
        resp.setTotalStudents(studentIds.size());

        long passCount = scores.stream().filter(s -> s.getIsPass() == 1).count();
        resp.setOverallPassRate(scores.isEmpty() ? BigDecimal.ZERO :
                BigDecimal.valueOf(passCount * 100.0 / scores.size()).setScale(1, RoundingMode.HALF_UP));

        Long docCount = docMapper.selectCount(
                new LambdaQueryWrapper<KnowledgeDocument>().eq(KnowledgeDocument::getUploaderId, userId));
        resp.setTotalDocs(docCount.intValue());

        Map<String, Integer> gradeDist = new LinkedHashMap<>();
        for (String g : List.of("A", "B", "C", "D", "F")) gradeDist.put(g, 0);
        for (Score s : scores) {
            if (s.getGradeLevel() != null) gradeDist.merge(s.getGradeLevel(), 1, Integer::sum);
        }
        resp.setGradeDistribution(gradeDist);

        Map<Long, List<Score>> byCourse = scores.stream()
                .collect(Collectors.groupingBy(Score::getCourseId));
        List<TeacherDashboardResp.CourseAvg> courseAvgs = new ArrayList<>();
        for (Course c : courses) {
            TeacherDashboardResp.CourseAvg ca = new TeacherDashboardResp.CourseAvg();
            ca.setCourseName(c.getCourseName());
            ca.setSubject(c.getSubject());
            List<Score> cs = byCourse.getOrDefault(c.getId(), List.of());
            ca.setStudentCount((long) cs.size());
            ca.setAvgScore(cs.stream()
                    .map(Score::getTotalScore)
                    .filter(Objects::nonNull)
                    .collect(Collectors.collectingAndThen(
                            Collectors.averagingDouble(BigDecimal::doubleValue),
                            v -> BigDecimal.valueOf(v).setScale(1, RoundingMode.HALF_UP))));
            courseAvgs.add(ca);
        }
        resp.setCourseAvgs(courseAvgs);

        return resp;
    }

    @Override
    public AdminDashboardResp getAdminDashboard() {
        AdminDashboardResp resp = new AdminDashboardResp();

        resp.setTotalUsers(userMapper.selectCount(null));
        resp.setAdminCount(userMapper.selectCount(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getRole, 0)));
        resp.setTeacherCount(userMapper.selectCount(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getRole, 1)));
        resp.setStudentCount(userMapper.selectCount(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getRole, 2)));

        resp.setTotalDocs(docMapper.selectCount(null));
        resp.setTotalScores(scoreMapper.selectCount(null));
        resp.setTotalPlans(planMapper.selectCount(null));

        resp.setAiAnalysisCount(logMapper.selectCount(
                new LambdaQueryWrapper<SysLog>().like(SysLog::getAction, "AI")));

        List<Score> allScores = scoreMapper.selectList(
                new LambdaQueryWrapper<Score>().isNotNull(Score::getGradeLevel));
        Map<String, Long> dist = new LinkedHashMap<>();
        for (String g : List.of("A", "B", "C", "D", "F")) dist.put(g, 0L);
        for (Score s : allScores) {
            if (s.getGradeLevel() != null) {
                dist.merge(s.getGradeLevel(), 1L, Long::sum);
            }
        }
        resp.setScoreDistribution(dist);

        return resp;
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
}

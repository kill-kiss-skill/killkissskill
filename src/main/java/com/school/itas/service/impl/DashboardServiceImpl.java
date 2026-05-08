package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.model.resp.AdminDashboardResp;
import com.school.itas.model.resp.StudentDashboardResp;
import com.school.itas.model.resp.TeacherDashboardResp;
import com.school.itas.model.resp.TeacherStudentResp;
import com.school.itas.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
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

    @Override
    public List<TeacherStudentResp> getTeacherStudents(Long userId) {
        List<Course> courses = courseMapper.selectList(
                new LambdaQueryWrapper<Course>().eq(Course::getTeacherId, userId));
        List<Long> courseIds = courses.stream().map(Course::getId).toList();
        if (courseIds.isEmpty()) return List.of();

        List<Score> scores = scoreMapper.selectList(
                new LambdaQueryWrapper<Score>().in(Score::getCourseId, courseIds));
        Map<Long, List<Score>> byStudent = scores.stream()
                .collect(Collectors.groupingBy(Score::getStudentId));

        return byStudent.entrySet().stream().map(entry -> {
            Long sid = entry.getKey();
            List<Score> ss = entry.getValue();
            StudentInfo si = studentInfoMapper.selectById(sid);
            SysUser user = si != null ? userMapper.selectById(si.getUserId()) : null;
            SysClass cls = si != null ? classMapper.selectById(si.getClassId()) : null;

            BigDecimal avg = ss.stream()
                    .map(Score::getTotalScore)
                    .filter(Objects::nonNull)
                    .collect(Collectors.collectingAndThen(
                            Collectors.averagingDouble(BigDecimal::doubleValue),
                            v -> BigDecimal.valueOf(v).setScale(1, RoundingMode.HALF_UP)));

            TeacherStudentResp r = new TeacherStudentResp();
            r.setStudentId(sid);
            r.setStudentName(user != null ? user.getRealName() : "未知");
            r.setStudentNo(si != null ? si.getStudentNo() : "");
            r.setClassName(cls != null ? cls.getClassName() : "");
            r.setAvgScore(avg);
            r.setScoreCount(ss.size());
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

        Map<String, List<Score>> bySubject = scores.stream()
                .collect(Collectors.groupingBy(s -> {
                    Course c = courseMapper.selectById(s.getCourseId());
                    return c != null ? c.getSubject() : "未知";
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

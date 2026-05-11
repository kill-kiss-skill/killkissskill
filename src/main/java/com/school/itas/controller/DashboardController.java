package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.resp.AdminDashboardResp;
import com.school.itas.model.resp.StudentDashboardResp;
import com.school.itas.model.resp.TeacherCourseResp;
import com.school.itas.model.resp.TeacherDashboardResp;
import com.school.itas.model.resp.TeacherStudentResp;
import com.school.itas.service.DashboardService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "仪表盘")
@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;

    @Operation(summary = "学生仪表盘数据")
    @GetMapping("/student")
    public Result<StudentDashboardResp> studentDashboard(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(dashboardService.getStudentDashboard(userId));
    }

    @Operation(summary = "教师仪表盘数据")
    @GetMapping("/teacher")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<TeacherDashboardResp> teacherDashboard(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(dashboardService.getTeacherDashboard(userId));
    }

    @Operation(summary = "教师学生列表")
    @GetMapping("/teacher/students")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<List<TeacherStudentResp>> teacherStudents(
            Authentication auth,
            @RequestParam(required = false) String keyword) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(dashboardService.getTeacherStudents(userId, keyword));
    }

    @Operation(summary = "教师课程列表")
    @GetMapping("/teacher/courses")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<List<TeacherCourseResp>> teacherCourses(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(dashboardService.getTeacherCourses(userId));
    }

    @Operation(summary = "管理员仪表盘数据")
    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<AdminDashboardResp> adminDashboard() {
        return Result.ok(dashboardService.getAdminDashboard());
    }
}

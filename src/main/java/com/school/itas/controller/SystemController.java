package com.school.itas.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.common.domain.Result;
import com.school.itas.entity.*;
import com.school.itas.service.SystemService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "系统管理")
@RestController
@RequestMapping("/api/system")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class SystemController {

    private final SystemService systemService;

    @Operation(summary = "院系列表")
    @GetMapping("/departments")
    public Result<List<SysDepartment>> listDepartments() {
        return Result.ok(systemService.listDepartments());
    }

    @Operation(summary = "新增院系")
    @PostMapping("/department")
    public Result<SysDepartment> createDepartment(@RequestParam String name) {
        return Result.ok(systemService.createDepartment(name));
    }

    @Operation(summary = "删除院系")
    @DeleteMapping("/department/{id}")
    public Result<Void> deleteDepartment(@PathVariable Long id) {
        systemService.deleteDepartment(id);
        return Result.ok();
    }

    @Operation(summary = "班级列表")
    @GetMapping("/classes")
    public Result<List<SysClass>> listClasses() {
        return Result.ok(systemService.listClasses());
    }

    @Operation(summary = "新增班级")
    @PostMapping("/class")
    public Result<SysClass> createClass(@RequestParam String className,
                                         @RequestParam Long departmentId,
                                         @RequestParam Integer grade,
                                         @RequestParam(required = false) Long teacherId) {
        return Result.ok(systemService.createClass(className, departmentId, grade, teacherId));
    }

    @Operation(summary = "删除班级")
    @DeleteMapping("/class/{id}")
    public Result<Void> deleteClass(@PathVariable Long id) {
        systemService.deleteClass(id);
        return Result.ok();
    }

    @Operation(summary = "课程列表")
    @GetMapping("/courses")
    public Result<List<Course>> listCourses() {
        return Result.ok(systemService.listCourses());
    }

    @Operation(summary = "新增课程")
    @PostMapping("/course")
    public Result<Course> createCourse(@RequestParam String courseCode,
                                        @RequestParam String courseName,
                                        @RequestParam String subject,
                                        @RequestParam(required = false) Long teacherId,
                                        @RequestParam String semester,
                                        @RequestParam(required = false) Long classId) {
        return Result.ok(systemService.createCourse(courseCode, courseName, subject, teacherId, semester, classId));
    }

    @Operation(summary = "删除课程")
    @DeleteMapping("/course/{id}")
    public Result<Void> deleteCourse(@PathVariable Long id) {
        systemService.deleteCourse(id);
        return Result.ok();
    }

    @Operation(summary = "系统日志")
    @GetMapping("/logs")
    public Result<Page<SysLog>> listLogs(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size,
            @RequestParam(required = false) Long userId) {
        return Result.ok(systemService.listLogs(page, size, userId));
    }
}

package com.school.itas.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.entity.*;

import java.util.List;

public interface SystemService {

    // 院系
    List<SysDepartment> listDepartments();
    SysDepartment createDepartment(String name);
    SysDepartment updateDepartment(Long id, String name);
    void deleteDepartment(Long id);

    // 班级
    List<SysClass> listClasses(String keyword, Long departmentId);
    SysClass createClass(String className, Long departmentId, Integer grade, Long teacherId);
    SysClass updateClass(Long id, String className, Long departmentId, Integer grade, Long teacherId);
    void deleteClass(Long id);

    // 课程
    List<Course> listCourses(String keyword, Long teacherId);
    Course createCourse(String courseCode, String courseName, String subject, Long teacherId, String semester, Long classId);
    Course updateCourse(Long id, String courseCode, String courseName, String subject, Long teacherId, String semester, Long classId);
    void deleteCourse(Long id);

    // 日志
    Page<SysLog> listLogs(Integer page, Integer size, String keyword);
}

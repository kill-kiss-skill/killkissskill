package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.service.SystemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SystemServiceImpl implements SystemService {

    private final SysDepartmentMapper departmentMapper;
    private final SysClassMapper classMapper;
    private final CourseMapper courseMapper;
    private final SysLogMapper logMapper;

    @Override
    public List<SysDepartment> listDepartments() {
        return departmentMapper.selectList(null);
    }

    @Override
    public SysDepartment createDepartment(String name) {
        SysDepartment d = new SysDepartment();
        d.setName(name);
        departmentMapper.insert(d);
        return d;
    }

    @Override
    public void deleteDepartment(Long id) {
        departmentMapper.deleteById(id);
    }

    @Override
    public List<SysClass> listClasses() {
        return classMapper.selectList(null);
    }

    @Override
    public SysClass createClass(String className, Long departmentId, Integer grade, Long teacherId) {
        SysClass c = new SysClass();
        c.setClassName(className);
        c.setDepartmentId(departmentId);
        c.setGrade(grade);
        c.setTeacherId(teacherId);
        classMapper.insert(c);
        return c;
    }

    @Override
    public SysClass updateClass(Long id, String className, Long departmentId, Integer grade, Long teacherId) {
        SysClass c = classMapper.selectById(id);
        if (c == null) return null;
        if (className != null) c.setClassName(className);
        if (departmentId != null) c.setDepartmentId(departmentId);
        if (grade != null) c.setGrade(grade);
        c.setTeacherId(teacherId);
        classMapper.updateById(c);
        return c;
    }

    @Override
    public void deleteClass(Long id) {
        classMapper.deleteById(id);
    }

    @Override
    public List<Course> listCourses() {
        return courseMapper.selectList(null);
    }

    @Override
    public Course createCourse(String courseCode, String courseName, String subject,
                                Long teacherId, String semester, Long classId) {
        Course c = new Course();
        c.setCourseCode(courseCode);
        c.setCourseName(courseName);
        c.setSubject(subject);
        c.setTeacherId(teacherId);
        c.setSemester(semester);
        c.setClassId(classId);
        courseMapper.insert(c);
        return c;
    }

    @Override
    public Course updateCourse(Long id, String courseCode, String courseName, String subject,
                                Long teacherId, String semester, Long classId) {
        Course c = courseMapper.selectById(id);
        if (c == null) return null;
        if (courseCode != null) c.setCourseCode(courseCode);
        if (courseName != null) c.setCourseName(courseName);
        if (subject != null) c.setSubject(subject);
        c.setTeacherId(teacherId);
        if (semester != null) c.setSemester(semester);
        c.setClassId(classId);
        courseMapper.updateById(c);
        return c;
    }

    @Override
    public void deleteCourse(Long id) {
        courseMapper.deleteById(id);
    }

    @Override
    public Page<SysLog> listLogs(Integer page, Integer size, Long userId) {
        LambdaQueryWrapper<SysLog> wrapper = new LambdaQueryWrapper<>();
        if (userId != null) wrapper.eq(SysLog::getUserId, userId);
        wrapper.orderByDesc(SysLog::getCreatedAt);
        return logMapper.selectPage(new Page<>(page, size), wrapper);
    }
}

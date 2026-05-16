package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.service.SystemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SystemServiceImpl implements SystemService {

    private final SysDepartmentMapper departmentMapper;
    private final SysClassMapper classMapper;
    private final CourseMapper courseMapper;
    private final SysLogMapper logMapper;
    private final SysUserMapper userMapper;

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
    public SysDepartment updateDepartment(Long id, String name) {
        SysDepartment d = departmentMapper.selectById(id);
        if (d == null) throw new BusinessException(404, "院系不存在");
        d.setName(name);
        departmentMapper.updateById(d);
        return d;
    }

    @Override
    public void deleteDepartment(Long id) {
        departmentMapper.deleteById(id);
    }

    @Override
    public List<SysClass> listClasses(String keyword, Long departmentId) {
        LambdaQueryWrapper<SysClass> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.like(SysClass::getClassName, keyword);
        }
        if (departmentId != null) {
            wrapper.eq(SysClass::getDepartmentId, departmentId);
        }
        return classMapper.selectList(wrapper);
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
        if (c == null) throw new BusinessException(404, "班级不存在");
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
    public List<Course> listCourses(String keyword, Long teacherId) {
        LambdaQueryWrapper<Course> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(Course::getCourseName, keyword)
                .or().like(Course::getSubject, keyword));
        }
        if (teacherId != null) {
            wrapper.eq(Course::getTeacherId, teacherId);
        }
        return courseMapper.selectList(wrapper);
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
        if (c == null) throw new BusinessException(404, "课程不存在");
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
    public Page<SysLog> listLogs(Integer page, Integer size, String keyword) {
        LambdaQueryWrapper<SysLog> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Long> userIds = userMapper.selectList(
                    new LambdaQueryWrapper<SysUser>().like(SysUser::getRealName, keyword))
                    .stream().map(SysUser::getId).toList();
            if (userIds.isEmpty()) {
                wrapper.eq(SysLog::getUserId, -1L);
            } else {
                wrapper.in(SysLog::getUserId, userIds);
            }
        }
        wrapper.orderByDesc(SysLog::getCreatedAt);
        return logMapper.selectPage(new Page<>(page, size), wrapper);
    }
}

package com.school.itas.service;

import com.school.itas.model.resp.AdminDashboardResp;
import com.school.itas.model.resp.StudentDashboardResp;
import com.school.itas.model.resp.TeacherDashboardResp;
import com.school.itas.model.resp.TeacherStudentResp;

import java.util.List;

public interface DashboardService {

    StudentDashboardResp getStudentDashboard(Long userId);

    TeacherDashboardResp getTeacherDashboard(Long userId);

    List<TeacherStudentResp> getTeacherStudents(Long userId);

    AdminDashboardResp getAdminDashboard();
}

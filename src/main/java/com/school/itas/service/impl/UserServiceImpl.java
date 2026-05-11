package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.common.enums.RoleEnum;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.common.utils.JwtUtil;
import com.school.itas.entity.StudentInfo;
import com.school.itas.entity.SysUser;
import com.school.itas.entity.TeacherInfo;
import com.school.itas.mapper.StudentInfoMapper;
import com.school.itas.mapper.SysUserMapper;
import com.school.itas.mapper.TeacherInfoMapper;
import com.school.itas.model.req.LoginReq;
import com.school.itas.model.req.UpdatePasswordReq;
import com.school.itas.model.req.UpdateProfileReq;
import com.school.itas.model.req.UserCreateReq;
import com.school.itas.model.resp.LoginResp;
import com.school.itas.model.resp.UserInfoResp;
import com.school.itas.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final SysUserMapper userMapper;
    private final StudentInfoMapper studentInfoMapper;
    private final TeacherInfoMapper teacherInfoMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    @Override
    public LoginResp login(LoginReq req) {
        SysUser user = userMapper.selectOne(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, req.getUsername()));
        if (user == null || !passwordEncoder.matches(req.getPassword(), user.getPassword())) {
            throw new BusinessException(401, "用户名或密码错误");
        }
        if (user.getStatus() == 0) {
            throw new BusinessException(403, "账号已被禁用");
        }
        RoleEnum role = RoleEnum.of(user.getRole());
        String token = jwtUtil.generate(user.getId(), user.getUsername(), role.getAuthority());

        LoginResp resp = new LoginResp();
        resp.setToken(token);
        resp.setUserId(user.getId());
        resp.setUsername(user.getUsername());
        resp.setRealName(user.getRealName());
        resp.setRole(user.getRole());
        return resp;
    }

    @Override
    public UserInfoResp getInfo(Long userId) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        UserInfoResp resp = toResp(user);
        if (user.getRole() == RoleEnum.STUDENT.getCode()) {
            StudentInfo si = studentInfoMapper.selectOne(
                    new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, userId));
            if (si != null) resp.setStudentInfoId(si.getId());
        } else if (user.getRole() == RoleEnum.TEACHER.getCode()) {
            TeacherInfo ti = teacherInfoMapper.selectOne(
                    new LambdaQueryWrapper<TeacherInfo>().eq(TeacherInfo::getUserId, userId));
            if (ti != null) resp.setTeacherInfoId(ti.getId());
        }
        return resp;
    }

    @Override
    @Transactional
    public void createUser(UserCreateReq req) {
        long count = userMapper.selectCount(
                new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, req.getUsername()));
        if (count > 0) throw new BusinessException("用户名已存在");

        SysUser user = new SysUser();
        user.setUsername(req.getUsername());
        user.setPassword(passwordEncoder.encode(req.getPassword()));
        user.setRealName(req.getRealName());
        user.setRole(req.getRole());
        user.setEmail(req.getEmail());
        user.setPhone(req.getPhone());
        user.setStatus(1);
        userMapper.insert(user);

        if (req.getRole() == RoleEnum.STUDENT.getCode() && req.getClassId() != null) {
            StudentInfo si = new StudentInfo();
            si.setUserId(user.getId());
            si.setStudentNo(req.getUsername());
            si.setClassId(req.getClassId());
            studentInfoMapper.insert(si);
        } else if (req.getRole() == RoleEnum.TEACHER.getCode()) {
            TeacherInfo ti = new TeacherInfo();
            ti.setUserId(user.getId());
            ti.setTeacherNo(req.getUsername());
            ti.setDepartmentId(req.getDepartmentId());
            teacherInfoMapper.insert(ti);
        }
    }

    @Override
    public void updateStatus(Long userId, Integer status) {
        SysUser user = new SysUser();
        user.setId(userId);
        user.setStatus(status);
        userMapper.updateById(user);
    }

    @Override
    public List<UserInfoResp> listUsers(Integer role, String keyword, Integer page, Integer size) {
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        if (role != null) wrapper.eq(SysUser::getRole, role);
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(SysUser::getUsername, keyword)
                .or().like(SysUser::getRealName, keyword)
                .or().like(SysUser::getEmail, keyword));
        }
        wrapper.orderByDesc(SysUser::getCreatedAt);
        Page<SysUser> p = userMapper.selectPage(new Page<>(page, size), wrapper);
        return p.getRecords().stream().map(this::toResp).toList();
    }

    @Override
    public void updatePassword(Long userId, UpdatePasswordReq req) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        if (!passwordEncoder.matches(req.getOldPassword(), user.getPassword())) {
            throw new BusinessException(400, "旧密码错误");
        }
        user.setPassword(passwordEncoder.encode(req.getNewPassword()));
        userMapper.updateById(user);
    }

    @Override
    public void updateProfile(Long userId, UpdateProfileReq req) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        user.setEmail(req.getEmail());
        user.setPhone(req.getPhone());
        userMapper.updateById(user);
    }

    @Override
    @Transactional
    public void updateUser(Long userId, UserCreateReq req) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        if (!user.getUsername().equals(req.getUsername())) {
            long count = userMapper.selectCount(
                    new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, req.getUsername()));
            if (count > 0) throw new BusinessException("用户名已存在");
        }
        user.setUsername(req.getUsername());
        user.setRealName(req.getRealName());
        user.setRole(req.getRole());
        user.setEmail(req.getEmail());
        user.setPhone(req.getPhone());
        userMapper.updateById(user);
    }

    @Override
    public void resetPassword(Long userId) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        user.setPassword(passwordEncoder.encode("123456"));
        userMapper.updateById(user);
    }

    @Override
    @Transactional
    public void deleteUser(Long userId) {
        SysUser user = userMapper.selectById(userId);
        if (user == null) throw new BusinessException(404, "用户不存在");
        studentInfoMapper.delete(new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, userId));
        teacherInfoMapper.delete(new LambdaQueryWrapper<TeacherInfo>().eq(TeacherInfo::getUserId, userId));
        userMapper.deleteById(userId);
    }

    private UserInfoResp toResp(SysUser user) {
        UserInfoResp resp = new UserInfoResp();
        resp.setId(user.getId());
        resp.setUsername(user.getUsername());
        resp.setRealName(user.getRealName());
        resp.setRole(user.getRole());
        resp.setEmail(user.getEmail());
        resp.setPhone(user.getPhone());
        resp.setAvatarUrl(user.getAvatarUrl());
        resp.setStatus(user.getStatus());
        resp.setCreatedAt(user.getCreatedAt());
        return resp;
    }
}

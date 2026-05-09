package com.school.itas.service;

import com.school.itas.model.req.LoginReq;
import com.school.itas.model.req.UpdatePasswordReq;
import com.school.itas.model.req.UpdateProfileReq;
import com.school.itas.model.req.UserCreateReq;
import com.school.itas.model.resp.LoginResp;
import com.school.itas.model.resp.UserInfoResp;

import java.util.List;

public interface UserService {

    LoginResp login(LoginReq req);

    UserInfoResp getInfo(Long userId);

    void createUser(UserCreateReq req);

    void updateStatus(Long userId, Integer status);

    List<UserInfoResp> listUsers(Integer role, Integer page, Integer size);

    void updatePassword(Long userId, UpdatePasswordReq req);

    void updateProfile(Long userId, UpdateProfileReq req);

    void updateUser(Long userId, UserCreateReq req);

    void resetPassword(Long userId);

    void deleteUser(Long userId);
}

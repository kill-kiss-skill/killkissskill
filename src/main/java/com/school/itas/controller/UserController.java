package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.req.LoginReq;
import com.school.itas.model.req.UpdatePasswordReq;
import com.school.itas.model.req.UpdateProfileReq;
import com.school.itas.model.resp.LoginResp;
import com.school.itas.model.resp.UserInfoResp;
import com.school.itas.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@Tag(name = "用户管理")
@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @Operation(summary = "登录")
    @PostMapping("/api/auth/login")
    public Result<LoginResp> login(@Valid @RequestBody LoginReq req) {
        return Result.ok(userService.login(req));
    }

    @Operation(summary = "获取当前用户信息")
    @GetMapping("/api/user/info")
    public Result<UserInfoResp> info(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(userService.getInfo(userId));
    }

    @Operation(summary = "修改密码")
    @PutMapping("/api/user/password")
    public Result<Void> updatePassword(@Valid @RequestBody UpdatePasswordReq req, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        userService.updatePassword(userId, req);
        return Result.ok();
    }

    @Operation(summary = "修改个人信息")
    @PutMapping("/api/user/profile")
    public Result<Void> updateProfile(@RequestBody UpdateProfileReq req, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        userService.updateProfile(userId, req);
        return Result.ok();
    }
}

package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.req.UserCreateReq;
import com.school.itas.model.resp.UserInfoResp;
import com.school.itas.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "管理员")
@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {

    private final UserService userService;

    @Operation(summary = "创建用户")
    @PostMapping("/user/create")
    public Result<Void> createUser(@Valid @RequestBody UserCreateReq req) {
        userService.createUser(req);
        return Result.ok();
    }

    @Operation(summary = "用户列表")
    @GetMapping("/users")
    public Result<List<UserInfoResp>> listUsers(
            @RequestParam(required = false) Integer role,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size) {
        return Result.ok(userService.listUsers(role, page, size));
    }

    @Operation(summary = "启用/禁用用户")
    @PutMapping("/user/{userId}/status")
    public Result<Void> updateStatus(@PathVariable Long userId, @RequestParam Integer status) {
        userService.updateStatus(userId, status);
        return Result.ok();
    }

    @Operation(summary = "编辑用户")
    @PutMapping("/user/{userId}")
    public Result<Void> updateUser(@PathVariable Long userId, @Valid @RequestBody UserCreateReq req) {
        userService.updateUser(userId, req);
        return Result.ok();
    }

    @Operation(summary = "重置密码")
    @PutMapping("/user/{userId}/reset-password")
    public Result<Void> resetPassword(@PathVariable Long userId) {
        userService.resetPassword(userId);
        return Result.ok();
    }

    @Operation(summary = "删除用户")
    @DeleteMapping("/user/{userId}")
    public Result<Void> deleteUser(@PathVariable Long userId) {
        userService.deleteUser(userId);
        return Result.ok();
    }
}

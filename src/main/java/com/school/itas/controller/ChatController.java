package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.req.ChatReq;
import com.school.itas.model.resp.ChatResp;
import com.school.itas.model.resp.SessionResp;
import com.school.itas.service.ChatService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "智能对话")
@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "发送消息")
    @PostMapping("/message")
    public Result<ChatResp> chat(@Valid @RequestBody ChatReq req, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(chatService.chat(userId, req));
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "获取会话历史")
    @GetMapping("/history")
    public Result<List<ChatResp>> history(@RequestParam String sessionKey, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(chatService.getHistory(userId, sessionKey));
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "获取会话列表")
    @GetMapping("/sessions")
    public Result<List<SessionResp>> sessions(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        return Result.ok(chatService.listSessions(userId));
    }

    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "删除会话")
    @DeleteMapping("/session")
    public Result<Void> deleteSession(@RequestParam String sessionKey, Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        chatService.deleteSession(userId, sessionKey);
        return Result.ok();
    }
}

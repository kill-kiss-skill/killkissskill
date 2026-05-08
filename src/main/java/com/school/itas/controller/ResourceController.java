package com.school.itas.controller;

import com.school.itas.common.domain.Result;
import com.school.itas.model.req.ResourceReq;
import com.school.itas.model.resp.ResourceResp;
import com.school.itas.service.ResourceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "学习资源")
@RestController
@RequestMapping("/api/resources")
@RequiredArgsConstructor
public class ResourceController {

    private final ResourceService resourceService;

    @Operation(summary = "资源列表")
    @GetMapping("/list")
    public Result<List<ResourceResp>> list(
            @RequestParam(required = false) String subject,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer size) {
        return Result.ok(resourceService.listResources(subject, page, size));
    }

    @Operation(summary = "资源详情")
    @GetMapping("/{id}")
    public Result<ResourceResp> detail(@PathVariable Long id) {
        return Result.ok(resourceService.getResource(id));
    }

    @Operation(summary = "新增资源")
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<ResourceResp> create(@Valid @RequestBody ResourceReq req, Authentication auth) {
        Long uploaderId = (Long) auth.getPrincipal();
        return Result.ok(resourceService.createResource(req, uploaderId));
    }

    @Operation(summary = "删除资源")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public Result<Void> delete(@PathVariable Long id) {
        resourceService.deleteResource(id);
        return Result.ok();
    }
}

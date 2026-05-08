package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.school.itas.common.exception.BusinessException;
import com.school.itas.entity.LearningResource;
import com.school.itas.mapper.LearningResourceMapper;
import com.school.itas.model.req.ResourceReq;
import com.school.itas.model.resp.ResourceResp;
import com.school.itas.service.ResourceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ResourceServiceImpl implements ResourceService {

    private final LearningResourceMapper resourceMapper;

    @Override
    public List<ResourceResp> listResources(String subject, Integer page, Integer size) {
        LambdaQueryWrapper<LearningResource> wrapper = new LambdaQueryWrapper<>();
        if (subject != null && !subject.isBlank()) {
            wrapper.eq(LearningResource::getSubject, subject);
        }
        wrapper.orderByDesc(LearningResource::getCreatedAt);
        Page<LearningResource> p = resourceMapper.selectPage(new Page<>(page, size), wrapper);
        return p.getRecords().stream().map(this::toResp).toList();
    }

    @Override
    public ResourceResp getResource(Long id) {
        LearningResource r = resourceMapper.selectById(id);
        if (r == null) throw new BusinessException(404, "资源不存在");
        r.setViewCount(r.getViewCount() + 1);
        resourceMapper.updateById(r);
        return toResp(r);
    }

    @Override
    public ResourceResp createResource(ResourceReq req, Long uploaderId) {
        LearningResource r = new LearningResource();
        r.setTitle(req.getTitle());
        r.setSubject(req.getSubject());
        r.setResType(req.getResType());
        r.setUrl(req.getUrl());
        r.setDescription(req.getDescription());
        r.setDifficulty(req.getDifficulty());
        r.setUploaderId(uploaderId);
        r.setViewCount(0);
        resourceMapper.insert(r);
        return toResp(r);
    }

    @Override
    public void deleteResource(Long id) {
        resourceMapper.deleteById(id);
    }

    private ResourceResp toResp(LearningResource r) {
        ResourceResp resp = new ResourceResp();
        resp.setId(r.getId());
        resp.setTitle(r.getTitle());
        resp.setSubject(r.getSubject());
        resp.setResType(r.getResType());
        resp.setUrl(r.getUrl());
        resp.setDescription(r.getDescription());
        resp.setDifficulty(r.getDifficulty());
        resp.setViewCount(r.getViewCount());
        resp.setCreatedAt(r.getCreatedAt());
        return resp;
    }
}

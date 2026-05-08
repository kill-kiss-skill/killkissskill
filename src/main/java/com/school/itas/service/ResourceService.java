package com.school.itas.service;

import com.school.itas.model.req.ResourceReq;
import com.school.itas.model.resp.ResourceResp;

import java.util.List;

public interface ResourceService {

    List<ResourceResp> listResources(String subject, Integer page, Integer size);

    ResourceResp getResource(Long id);

    ResourceResp createResource(ResourceReq req, Long uploaderId);

    void deleteResource(Long id);
}

package com.school.itas.service;

import com.school.itas.model.req.ChatReq;
import com.school.itas.model.resp.ChatResp;
import com.school.itas.model.resp.SessionResp;

import java.util.List;

public interface ChatService {

    ChatResp chat(Long userId, ChatReq req);

    List<ChatResp> getHistory(Long userId, String sessionKey);

    void deleteSession(Long userId, String sessionKey);

    List<SessionResp> listSessions(Long userId);
}

package com.school.itas.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.agent.ChatAgent;
import com.school.itas.agent.MasterAgent;
import com.school.itas.agent.ResourceAgent;
import com.school.itas.common.enums.AgentTypeEnum;
import com.school.itas.entity.*;
import com.school.itas.mapper.*;
import com.school.itas.model.dto.RagResultDTO;
import com.school.itas.model.req.ChatReq;
import com.school.itas.model.resp.ChatResp;
import com.school.itas.model.resp.SessionResp;
import com.school.itas.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService {

    private final MasterAgent masterAgent;
    private final ChatAgent chatAgent;
    private final ResourceAgent resourceAgent;
    private final ChatSessionMapper sessionMapper;
    private final ChatMessageMapper messageMapper;
    private final LearningResourceMapper resourceMapper;
    private final StudentInfoMapper studentInfoMapper;
    private final ScoreMapper scoreMapper;

    @Override
    @Transactional
    public ChatResp chat(Long userId, ChatReq req) {
        // 获取或创建会话
        ChatSession session = getOrCreateSession(userId, req.getSessionKey(), AgentTypeEnum.CHAT.getCode());

        // 保存用户消息
        saveMessage(session.getId(), "user", req.getMessage(), null, null);

        // MasterAgent 路由
        AgentTypeEnum agentType = masterAgent.route(req.getMessage());

        String answer;
        RagResultDTO ragResult = null;

        if (agentType == AgentTypeEnum.CHAT) {
            RagResultDTO[] ragOut = new RagResultDTO[1];
            answer = chatAgent.answer(req.getMessage(), req.getSubject(), ragOut);
            ragResult = ragOut[0];
        } else if (agentType == AgentTypeEnum.RESOURCE) {
            StudentInfo si = studentInfoMapper.selectOne(
                    new LambdaQueryWrapper<StudentInfo>().eq(StudentInfo::getUserId, userId));
            Long scoreStudentId = si != null ? si.getId() : userId;
            List<Map<String, Object>> avgList = scoreMapper.selectAvgScoreBySubject(scoreStudentId);
            List<String> weakSubjects = avgList.stream()
                    .filter(row -> {
                        Object v = row.get("avgScore");
                        return v != null && Double.parseDouble(v.toString()) < 60;
                    })
                    .map(row -> row.get("subject").toString())
                    .toList();
            if (weakSubjects.isEmpty() && !avgList.isEmpty()) {
                weakSubjects = List.of(req.getSubject());
            }
            List<LearningResource> resources = resourceMapper.selectList(null);
            answer = resourceAgent.recommend(weakSubjects, req.getSubject(), resources);
        } else {
            // ANALYZE 路由到 chat 兜底
            RagResultDTO[] ragOut = new RagResultDTO[1];
            answer = chatAgent.answer(req.getMessage(), req.getSubject(), ragOut);
            ragResult = ragOut[0];
        }

        // 保存 AI 回复
        String ragContextJson = ragResult != null && !ragResult.getChunks().isEmpty()
                ? ragResult.getContextText() : null;
        String refIds = ragResult != null && !ragResult.getChunks().isEmpty()
                ? ragResult.getChunks().stream()
                    .map(c -> String.valueOf(c.getChunkId()))
                    .reduce((a, b) -> a + "," + b).orElse(null)
                : null;
        saveMessage(session.getId(), "assistant", answer, ragContextJson, refIds);

        // 更新会话标题
        if (session.getTitle() == null) {
            String title = req.getMessage().length() > 20
                    ? req.getMessage().substring(0, 20) + "..." : req.getMessage();
            session.setTitle(title);
            sessionMapper.updateById(session);
        }

        ChatResp resp = new ChatResp();
        resp.setSessionKey(session.getSessionKey());
        resp.setAnswer(answer);
        if (ragResult != null) {
            resp.setReferences(ragResult.getChunks().stream().map(c -> {
                ChatResp.ChunkRef ref = new ChatResp.ChunkRef();
                ref.setChunkId(c.getChunkId());
                ref.setDocTitle(c.getDocTitle());
                ref.setContent(c.getContent() != null && c.getContent().length() > 100
                        ? c.getContent().substring(0, 100) + "..." : c.getContent());
                return ref;
            }).toList());
        }
        return resp;
    }

    @Override
    public List<ChatResp> getHistory(Long userId, String sessionKey) {
        ChatSession session = sessionMapper.selectOne(
                new LambdaQueryWrapper<ChatSession>()
                        .eq(ChatSession::getSessionKey, sessionKey)
                        .eq(ChatSession::getUserId, userId));
        if (session == null) return List.of();

        return messageMapper.selectList(
                new LambdaQueryWrapper<ChatMessage>()
                        .eq(ChatMessage::getSessionId, session.getId())
                        .orderByAsc(ChatMessage::getCreatedAt))
                .stream().map(m -> {
                    ChatResp r = new ChatResp();
                    r.setSessionKey(sessionKey);
                    r.setRole(m.getRole());
                    r.setAnswer(m.getContent());
                    if (m.getRefChunkIds() != null) {
                        String[] ids = m.getRefChunkIds().split(",");
                        r.setReferences(java.util.Arrays.stream(ids)
                                .filter(id -> !id.isBlank())
                                .map(id -> {
                                    ChatResp.ChunkRef ref = new ChatResp.ChunkRef();
                                    ref.setChunkId(Long.valueOf(id));
                                    return ref;
                                }).toList());
                    }
                    return r;
                }).toList();
    }

    @Override
    public List<SessionResp> listSessions(Long userId) {
        return sessionMapper.selectList(
                new LambdaQueryWrapper<ChatSession>()
                        .eq(ChatSession::getUserId, userId)
                        .orderByDesc(ChatSession::getUpdatedAt))
                .stream().map(s -> {
                    SessionResp r = new SessionResp();
                    r.setSessionKey(s.getSessionKey());
                    r.setTitle(s.getTitle());
                    r.setAgentType(s.getAgentType());
                    r.setCreatedAt(s.getCreatedAt());
                    r.setUpdatedAt(s.getUpdatedAt());
                    return r;
                }).toList();
    }

    @Override
    public void deleteSession(Long userId, String sessionKey) {
        sessionMapper.update(null,
                new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<ChatSession>()
                        .eq(ChatSession::getSessionKey, sessionKey)
                        .eq(ChatSession::getUserId, userId)
                        .set(ChatSession::getDeleted, 1));
    }

    private ChatSession getOrCreateSession(Long userId, String sessionKey, String agentType) {
        if (sessionKey != null && !sessionKey.isBlank()) {
            ChatSession s = sessionMapper.selectOne(
                    new LambdaQueryWrapper<ChatSession>()
                            .eq(ChatSession::getSessionKey, sessionKey)
                            .eq(ChatSession::getUserId, userId));
            if (s != null) return s;
        }
        ChatSession s = new ChatSession();
        s.setSessionKey(UUID.randomUUID().toString().replace("-", ""));
        s.setUserId(userId);
        s.setAgentType(agentType);
        sessionMapper.insert(s);
        return s;
    }

    private void saveMessage(Long sessionId, String role, String content,
                              String ragContext, String refChunkIds) {
        ChatMessage msg = new ChatMessage();
        msg.setSessionId(sessionId);
        msg.setRole(role);
        msg.setContent(content);
        msg.setRagContext(ragContext);
        msg.setRefChunkIds(refChunkIds);
        messageMapper.insert(msg);
    }
}

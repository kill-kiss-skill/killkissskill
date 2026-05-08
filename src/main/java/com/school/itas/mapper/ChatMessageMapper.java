package com.school.itas.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.school.itas.entity.ChatMessage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMessageMapper extends BaseMapper<ChatMessage> {
}

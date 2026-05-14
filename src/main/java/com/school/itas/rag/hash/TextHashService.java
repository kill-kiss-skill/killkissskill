package com.school.itas.rag.hash;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.school.itas.entity.KnowledgeChunk;
import com.school.itas.mapper.KnowledgeChunkMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class TextHashService {

    private final KnowledgeChunkMapper chunkMapper;

    public String hash(String text) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(text.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 not available", e);
        }
    }

    public List<String> filterNewChunks(List<String> chunkTexts) {
        if (chunkTexts.isEmpty()) return List.of();

        List<String> hashes = chunkTexts.stream().map(this::hash).toList();
        Set<String> existingHashes = chunkMapper.selectList(
                new LambdaQueryWrapper<KnowledgeChunk>()
                        .in(KnowledgeChunk::getContentHash, hashes)
                        .select(KnowledgeChunk::getContentHash)
        ).stream().map(KnowledgeChunk::getContentHash).collect(Collectors.toSet());

        List<String> newChunks = new ArrayList<>();
        for (int i = 0; i < chunkTexts.size(); i++) {
            if (!existingHashes.contains(hashes.get(i))) {
                newChunks.add(chunkTexts.get(i));
            }
        }
        return newChunks;
    }
}

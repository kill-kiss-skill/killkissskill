package com.school.itas.rag.embedding;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.locks.LockSupport;

@Slf4j
@Component
public class EmbeddingRateLimiter {

    private final double permitsPerMilli;
    private final AtomicLong lastAcquireTime = new AtomicLong(System.currentTimeMillis());

    public EmbeddingRateLimiter(@Value("${itas.import.embedding-rpm:200}") int rpm) {
        this.permitsPerMilli = (double) rpm / 60_000.0;
    }

    public void acquire(int count) {
        long waitMs = (long) (count / permitsPerMilli);
        long now = System.currentTimeMillis();
        long last = lastAcquireTime.getAndSet(now + waitMs);
        long mustWait = last - now;
        if (mustWait > 0) {
            log.debug("Rate limiter: waiting {}ms for {} permits", mustWait, count);
            LockSupport.parkNanos(mustWait * 1_000_000L);
        }
    }
}

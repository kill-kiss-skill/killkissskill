package com.school.itas.aspect;

import com.school.itas.entity.SysLog;
import com.school.itas.mapper.SysLogMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.time.LocalDateTime;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class SysLogAspect {

    private final HttpServletRequest request;
    private final SysLogMapper sysLogMapper;

    @Around("execution(* com.school.itas.controller..*(..))")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = null;
        int status = 200;
        try {
            result = pjp.proceed();
            return result;
        } catch (Throwable e) {
            status = 500;
            throw e;
        } finally {
            try {
                long cost = System.currentTimeMillis() - start;

                SysLog sysLog = new SysLog();
                sysLog.setModule(getModule(pjp));
                sysLog.setAction(getAction(pjp));
                sysLog.setMethod(request.getMethod());
                sysLog.setRequestUrl(request.getRequestURI());
                sysLog.setIp(getClientIp(request));
                sysLog.setStatus(status);
                sysLog.setCostMs((int) cost);
                sysLog.setUserId(getCurrentUserId());
                sysLog.setCreatedAt(LocalDateTime.now());

                sysLogMapper.insert(sysLog);
            } catch (Exception e) {
                log.warn("Failed to save operation log: {}", e.getMessage());
            }
        }
    }

    private String getModule(ProceedingJoinPoint pjp) {
        Class<?> clazz = pjp.getTarget().getClass();
        Tag tag = clazz.getAnnotation(Tag.class);
        return tag != null ? tag.name() : clazz.getSimpleName();
    }

    private String getAction(ProceedingJoinPoint pjp) {
        MethodSignature signature = (MethodSignature) pjp.getSignature();
        Method method = signature.getMethod();
        Operation op = method.getAnnotation(Operation.class);
        return op != null ? op.summary() : method.getName();
    }

    private Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof Long) {
            return (Long) auth.getPrincipal();
        }
        return null;
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}

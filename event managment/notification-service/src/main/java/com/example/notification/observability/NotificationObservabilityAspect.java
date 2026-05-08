package com.example.notification.observability;

import java.util.Arrays;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class NotificationObservabilityAspect {

    private static final Logger log = LoggerFactory.getLogger(NotificationObservabilityAspect.class);

    @Around("execution(public * com.example.notification.service..*(..))")
    public Object observeNotificationService(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.nanoTime();
        String signature = joinPoint.getSignature().toShortString();
        log.info("observability service=notification event=start method={} args={}", signature, Arrays.toString(joinPoint.getArgs()));
        try {
            Object result = joinPoint.proceed();
            long durationMs = (System.nanoTime() - start) / 1_000_000;
            log.info("observability service=notification event=success method={} durationMs={}", signature, durationMs);
            return result;
        } catch (Throwable ex) {
            long durationMs = (System.nanoTime() - start) / 1_000_000;
            log.warn("observability service=notification event=failure method={} durationMs={} exception={}", signature, durationMs, ex.getClass().getSimpleName());
            throw ex;
        }
    }
}
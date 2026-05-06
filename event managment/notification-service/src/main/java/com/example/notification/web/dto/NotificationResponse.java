package com.example.notification.web.dto;

import com.example.notification.domain.NotificationType;
import java.time.OffsetDateTime;
import java.util.UUID;

public record NotificationResponse(
        UUID notificationId,
        UUID attendeeId,
        UUID eventId,
        String message,
        NotificationType type,
        boolean read,
        OffsetDateTime createdAt
) {
}

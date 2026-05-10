package com.example.notification.pubsub;

import com.example.notification.domain.NotificationType;
import java.util.List;
import java.util.UUID;

public record NotificationEvent(
        UUID eventId,
        List<UUID> attendeeIds,
        NotificationType type,
        String message
) {
    public NotificationEvent {
        attendeeIds = attendeeIds == null ? List.of() : attendeeIds;
    }
}

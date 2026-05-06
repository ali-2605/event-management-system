package com.example.event.service.client;

import com.example.event.domain.NotificationType;
import java.util.List;
import java.util.UUID;

public record NotifyAttendeesRequest(
        UUID eventId,
        List<UUID> attendeeIds,
        NotificationType type,
        String message
) {
}

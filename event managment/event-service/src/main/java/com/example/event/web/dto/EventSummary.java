package com.example.event.web.dto;

import com.example.event.domain.EventStatus;
import java.util.UUID;

public record EventSummary(
        UUID eventId,
        EventStatus status,
        Integer capacity
) {
}

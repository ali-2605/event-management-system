package com.example.event.web.dto;

import com.example.event.domain.EventStatus;
import java.time.OffsetDateTime;
import java.util.UUID;

public record EventResponse(
        UUID eventId,
        String title,
        String description,
        String location,
        OffsetDateTime startsAt,
        OffsetDateTime endsAt,
        Integer capacity,
        UUID organizerId,
        EventStatus status,
        OffsetDateTime createdAt
) {
}

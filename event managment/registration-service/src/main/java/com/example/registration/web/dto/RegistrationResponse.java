package com.example.registration.web.dto;

import com.example.registration.domain.RegistrationStatus;
import java.time.OffsetDateTime;
import java.util.UUID;

public record RegistrationResponse(
        UUID registrationId,
        UUID eventId,
        UUID attendeeId,
        RegistrationStatus status,
        OffsetDateTime registeredAt,
        OffsetDateTime canceledAt
) {
}

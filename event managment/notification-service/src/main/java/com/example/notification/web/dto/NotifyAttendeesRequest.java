package com.example.notification.web.dto;

import com.example.notification.domain.NotificationType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;

public record NotifyAttendeesRequest(
        @NotNull UUID eventId,
        @NotEmpty List<UUID> attendeeIds,
        @NotNull NotificationType type,
        @NotBlank String message
) {
}

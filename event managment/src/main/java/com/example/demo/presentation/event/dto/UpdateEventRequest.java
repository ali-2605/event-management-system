package com.example.demo.presentation.event.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.time.OffsetDateTime;

public record UpdateEventRequest(
        @NotBlank String title,
        String description,
        @NotBlank String location,
        @NotNull OffsetDateTime startsAt,
        @NotNull OffsetDateTime endsAt,
        @NotNull @Positive Integer capacity
) {
}

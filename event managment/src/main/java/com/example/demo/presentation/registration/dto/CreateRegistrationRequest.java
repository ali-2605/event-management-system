package com.example.demo.presentation.registration.dto;

import jakarta.validation.constraints.NotNull;

public record CreateRegistrationRequest(@NotNull Long attendeeId) {
}

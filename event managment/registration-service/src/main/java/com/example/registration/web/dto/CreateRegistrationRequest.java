package com.example.registration.web.dto;

import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public record CreateRegistrationRequest(@NotNull UUID eventId) {
}

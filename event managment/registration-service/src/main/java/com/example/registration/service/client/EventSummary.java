package com.example.registration.service.client;

import java.util.UUID;

public record EventSummary(UUID eventId, EventStatus status, Integer capacity) {
}

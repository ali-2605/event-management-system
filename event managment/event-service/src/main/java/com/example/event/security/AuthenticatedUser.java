package com.example.event.security;

import java.util.UUID;

public record AuthenticatedUser(UUID userId, UserRole role) {
}

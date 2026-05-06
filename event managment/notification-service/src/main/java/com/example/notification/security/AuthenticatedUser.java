package com.example.notification.security;

import java.util.UUID;

public record AuthenticatedUser(UUID userId, UserRole role) {
}

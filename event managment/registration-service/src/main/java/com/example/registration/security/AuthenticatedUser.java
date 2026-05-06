package com.example.registration.security;

import java.util.UUID;

public record AuthenticatedUser(UUID userId, UserRole role) {
}

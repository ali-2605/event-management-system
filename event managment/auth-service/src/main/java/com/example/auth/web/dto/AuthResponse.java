package com.example.auth.web.dto;

import com.example.auth.domain.Role;

public record AuthResponse(
        String token,
        String name,
        String email,
        Role role
) {
}

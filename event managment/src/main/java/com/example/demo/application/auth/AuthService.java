package com.example.demo.application.auth;

import com.example.demo.common.ApiMessage;
import com.example.demo.presentation.auth.dto.AuthResponse;
import com.example.demo.presentation.auth.dto.LoginRequest;
import com.example.demo.presentation.auth.dto.RegisterRequest;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    public ApiMessage register(RegisterRequest request) {
        return new ApiMessage("Register endpoint scaffolded. Implement password hashing, role checks, and user persistence here.");
    }

    public AuthResponse login(LoginRequest request) {
        return new AuthResponse(null, "Login endpoint scaffolded. Implement credential validation and JWT token generation here.");
    }
}

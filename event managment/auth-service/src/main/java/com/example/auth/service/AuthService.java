package com.example.auth.service;

import com.example.auth.data.UserRepository;
import com.example.auth.domain.Role;
import com.example.auth.domain.UserAccount;
import com.example.auth.security.JwtService;
import com.example.auth.web.dto.AuthResponse;
import com.example.auth.web.dto.LoginRequest;
import com.example.auth.web.dto.RegisterRequest;
import java.util.UUID;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
    }

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.findByEmail(request.email()).isPresent()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email is already registered.");
        }

        Role role = request.role();
        UserAccount user = new UserAccount(
                UUID.randomUUID(),
                request.name(),
                request.email(),
                passwordEncoder.encode(request.password()),
                role
        );
        userRepository.save(user);
        return new AuthResponse(jwtService.generateToken(user.getId(), role));
    }

    public AuthResponse login(LoginRequest request) {
        UserAccount user = userRepository.findByEmail(request.email())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password."));

        if (!passwordEncoder.matches(request.password(), user.getPasswordHash())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email or password.");
        }

        return new AuthResponse(jwtService.generateToken(user.getId(), user.getRole()));
    }
}

package com.example.auth.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.example.auth.data.UserRepository;
import com.example.auth.domain.Role;
import com.example.auth.domain.UserAccount;
import com.example.auth.security.JwtService;
import com.example.auth.web.dto.AuthResponse;
import com.example.auth.web.dto.LoginRequest;
import com.example.auth.web.dto.RegisterRequest;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.server.ResponseStatusException;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private JwtService jwtService;

    @InjectMocks
    private AuthService authService;

    private RegisterRequest registerRequest;

    @BeforeEach
    void setUp() {
        registerRequest = new RegisterRequest("Test User", "test@example.com", "pass123", Role.ATTENDEE);
    }

    @Test
    void registerCreatesUserAndReturnsToken() {
        when(userRepository.findByEmail(registerRequest.email())).thenReturn(Optional.empty());
        when(passwordEncoder.encode(registerRequest.password())).thenReturn("encoded-pass");
        when(jwtService.generateToken(any(), eq(Role.ATTENDEE))).thenReturn("jwt-token");

        AuthResponse response = authService.register(registerRequest);

        assertThat(response.token()).isEqualTo("jwt-token");
        verify(userRepository).save(any(UserAccount.class));
    }

    @Test
    void registerWithDuplicateEmailReturnsConflict() {
        when(userRepository.findByEmail(registerRequest.email())).thenReturn(Optional.of(anyUser()));

        assertThatThrownBy(() -> authService.register(registerRequest))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
                    assertThat(statusEx.getReason()).contains("already registered");
                });
    }

    @Test
    void loginWithUnknownEmailReturnsUnauthorized() {
        when(userRepository.findByEmail("missing@example.com")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> authService.login(new LoginRequest("missing@example.com", "pass123")))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
                    assertThat(statusEx.getReason()).contains("Invalid email or password");
                });
    }

    @Test
    void loginWithWrongPasswordReturnsUnauthorized() {
        UserAccount user = anyUser();
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("wrong", user.getPasswordHash())).thenReturn(false);

        assertThatThrownBy(() -> authService.login(new LoginRequest("test@example.com", "wrong")))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
                    assertThat(statusEx.getReason()).contains("Invalid email or password");
                });
    }

    @Test
    void loginWithValidCredentialsReturnsToken() {
        UserAccount user = anyUser();
        when(userRepository.findByEmail("test@example.com")).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("pass123", user.getPasswordHash())).thenReturn(true);
        when(jwtService.generateToken(user.getId(), user.getRole())).thenReturn("jwt-token");

        AuthResponse response = authService.login(new LoginRequest("test@example.com", "pass123"));

        assertThat(response.token()).isEqualTo("jwt-token");
    }

    private UserAccount anyUser() {
        return new UserAccount(
                java.util.UUID.fromString("11111111-1111-1111-1111-111111111111"),
                "Existing User",
                "test@example.com",
                "encoded-pass",
                Role.ATTENDEE
        );
    }
}

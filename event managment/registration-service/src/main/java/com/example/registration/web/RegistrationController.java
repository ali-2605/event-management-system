package com.example.registration.web;

import com.example.registration.security.AuthenticatedUser;
import com.example.registration.security.SecurityUtils;
import com.example.registration.service.RegistrationService;
import com.example.registration.web.dto.CreateRegistrationRequest;
import com.example.registration.web.dto.RegistrationResponse;
import jakarta.validation.Valid;
import java.util.List;
import java.util.UUID;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RegistrationController {

    private final RegistrationService registrationService;

    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @PostMapping("/api/registrations")
    @PreAuthorize("hasRole('ATTENDEE')")
    public RegistrationResponse register(@Valid @RequestBody CreateRegistrationRequest request) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return registrationService.registerForEvent(user, request);
    }

    @DeleteMapping("/api/registrations/{registrationId}")
    @PreAuthorize("hasRole('ATTENDEE')")
    public RegistrationResponse cancel(@PathVariable UUID registrationId) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return registrationService.cancelRegistration(user, registrationId);
    }

    @GetMapping("/api/registrations/event/{eventId}")
    public List<RegistrationResponse> getRegistrationsForEvent(@PathVariable UUID eventId) {
        return registrationService.getRegistrationsForEvent(eventId);
    }

    @GetMapping("/api/registrations/me")
    @PreAuthorize("hasRole('ATTENDEE')")
    public List<RegistrationResponse> getMyRegistrations() {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return registrationService.getMyRegistrations(user);
    }

    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse("ok");
    }

    public record HealthResponse(String status) {
    }
}

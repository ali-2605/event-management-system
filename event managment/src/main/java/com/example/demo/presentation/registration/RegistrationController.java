package com.example.demo.presentation.registration;

import com.example.demo.application.registration.RegistrationService;
import com.example.demo.common.ApiMessage;
import com.example.demo.presentation.registration.dto.CreateRegistrationRequest;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class RegistrationController {

    private final RegistrationService registrationService;

    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @PostMapping("/events/{eventId}/registrations")
    public ResponseEntity<ApiMessage> registerForEvent(
            @PathVariable Long eventId,
            @Valid @RequestBody CreateRegistrationRequest request
    ) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(registrationService.registerForEvent(eventId, request));
    }

    @DeleteMapping("/registrations/{registrationId}")
    public ResponseEntity<ApiMessage> cancelRegistration(@PathVariable Long registrationId) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(registrationService.cancelRegistration(registrationId));
    }

    @GetMapping("/events/{eventId}/registrations")
    public ResponseEntity<ApiMessage> getEventAttendees(@PathVariable Long eventId) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(registrationService.getEventAttendees(eventId));
    }
}

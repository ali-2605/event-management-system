package com.example.registration.web;

import com.example.registration.service.RegistrationService;
import java.util.List;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/internal/registrations")
public class InternalRegistrationController {

    private final RegistrationService registrationService;

    public InternalRegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @GetMapping("/event/{eventId}/attendees")
    public List<UUID> getAttendees(@PathVariable UUID eventId) {
        return registrationService.getActiveAttendeeIds(eventId);
    }

    @GetMapping("/event/{eventId}/count")
    public int getActiveCount(@PathVariable UUID eventId) {
        return registrationService.getActiveRegistrationCount(eventId);
    }

    @PostMapping("/event/{eventId}/cancel")
    public int cancelRegistrations(@PathVariable UUID eventId) {
        return registrationService.cancelRegistrationsForEvent(eventId);
    }
}

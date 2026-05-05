package com.example.demo.application.registration;

import com.example.demo.common.ApiMessage;
import com.example.demo.presentation.registration.dto.CreateRegistrationRequest;
import org.springframework.stereotype.Service;

@Service
public class RegistrationService {

    public ApiMessage registerForEvent(Long eventId, CreateRegistrationRequest request) {
        return new ApiMessage("Registration scaffolded for event id " + eventId + ". Implement duplicate checks and capacity enforcement here.");
    }

    public ApiMessage cancelRegistration(Long registrationId) {
        return new ApiMessage("Cancel registration scaffolded for registration id " + registrationId + ". Implement attendee ownership checks here.");
    }

    public ApiMessage getEventAttendees(Long eventId) {
        return new ApiMessage("Attendee tracking scaffolded for event id " + eventId + ". Implement attendee listing here.");
    }
}

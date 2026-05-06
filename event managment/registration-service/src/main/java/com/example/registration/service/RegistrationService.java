package com.example.registration.service;

import com.example.registration.data.RegistrationRepository;
import com.example.registration.domain.Registration;
import com.example.registration.domain.RegistrationStatus;
import com.example.registration.security.AuthenticatedUser;
import com.example.registration.security.UserRole;
import com.example.registration.service.client.EventClient;
import com.example.registration.service.client.EventStatus;
import com.example.registration.service.client.EventSummary;
import com.example.registration.web.dto.CreateRegistrationRequest;
import com.example.registration.web.dto.RegistrationResponse;
import java.util.List;
import java.util.UUID;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class RegistrationService {

    private final RegistrationRepository registrationRepository;
    private final EventClient eventClient;

    public RegistrationService(RegistrationRepository registrationRepository, EventClient eventClient) {
        this.registrationRepository = registrationRepository;
        this.eventClient = eventClient;
    }

    public RegistrationResponse registerForEvent(AuthenticatedUser user, CreateRegistrationRequest request) {
        requireAttendee(user);
        UUID eventId = request.eventId();
        EventSummary event = eventClient.getEventSummary(eventId);
        if (event == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found.");
        }
        if (event.status() == EventStatus.CANCELED) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Cannot register for a canceled event.");
        }

        long activeCount = registrationRepository.countByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE);
        if (event.capacity() != null && activeCount >= event.capacity()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Event capacity has been reached.");
        }

        Registration registration = registrationRepository.findByEventIdAndAttendeeId(eventId, user.userId()).orElse(null);
        if (registration != null) {
            if (registration.getStatus() == RegistrationStatus.ACTIVE) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "You are already registered for this event.");
            }
            registration.reactivate();
            registrationRepository.save(registration);
            return toResponse(registration);
        }

        registration = new Registration(UUID.randomUUID(), eventId, user.userId());
        registrationRepository.save(registration);
        return toResponse(registration);
    }

    public RegistrationResponse cancelRegistration(AuthenticatedUser user, UUID registrationId) {
        requireAttendee(user);
        Registration registration = registrationRepository.findById(registrationId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Registration not found."));
        if (!registration.getAttendeeId().equals(user.userId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You can only cancel your own registration.");
        }
        if (registration.getStatus() == RegistrationStatus.CANCELED) {
            return toResponse(registration);
        }
        registration.cancel();
        registrationRepository.save(registration);
        return toResponse(registration);
    }

    public List<RegistrationResponse> getRegistrationsForEvent(UUID eventId) {
        return registrationRepository.findAllByEventId(eventId).stream().map(this::toResponse).toList();
    }

    public List<RegistrationResponse> getMyRegistrations(AuthenticatedUser user) {
        requireAttendee(user);
        return registrationRepository.findAllByAttendeeId(user.userId()).stream().map(this::toResponse).toList();
    }

    public List<UUID> getActiveAttendeeIds(UUID eventId) {
        return registrationRepository.findAllByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE)
                .stream()
                .map(Registration::getAttendeeId)
                .toList();
    }

    public int getActiveRegistrationCount(UUID eventId) {
        return (int) registrationRepository.countByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE);
    }

    public int cancelRegistrationsForEvent(UUID eventId) {
        List<Registration> activeRegistrations = registrationRepository.findAllByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE);
        activeRegistrations.forEach(Registration::cancel);
        registrationRepository.saveAll(activeRegistrations);
        return activeRegistrations.size();
    }

    private RegistrationResponse toResponse(Registration registration) {
        return new RegistrationResponse(
                registration.getId(),
                registration.getEventId(),
                registration.getAttendeeId(),
                registration.getStatus(),
                registration.getRegisteredAt(),
                registration.getCanceledAt()
        );
    }

    private void requireAttendee(AuthenticatedUser user) {
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required.");
        }
        if (user.role() != UserRole.ATTENDEE) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Attendee role required.");
        }
    }
}

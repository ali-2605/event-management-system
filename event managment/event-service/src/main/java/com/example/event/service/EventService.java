package com.example.event.service;

import com.example.event.data.EventRepository;
import com.example.event.domain.Event;
import com.example.event.domain.EventStatus;
import com.example.event.domain.NotificationType;
import com.example.event.security.AuthenticatedUser;
import com.example.event.security.UserRole;
import com.example.event.service.client.NotificationClient;
import com.example.event.service.client.RegistrationClient;
import com.example.event.web.dto.CreateEventRequest;
import com.example.event.web.dto.EventResponse;
import com.example.event.web.dto.EventSummary;
import com.example.event.web.dto.UpdateEventRequest;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class EventService {

    private static final Set<String> ALLOWED_SORT_FIELDS = Set.of("startsAt", "endsAt", "capacity", "createdAt");

    private final EventRepository eventRepository;
    private final RegistrationClient registrationClient;
    private final NotificationClient notificationClient;

    public EventService(EventRepository eventRepository, RegistrationClient registrationClient, NotificationClient notificationClient) {
        this.eventRepository = eventRepository;
        this.registrationClient = registrationClient;
        this.notificationClient = notificationClient;
    }

    public List<EventResponse> getEvents(
            AuthenticatedUser user,
            Boolean mine,
            EventStatus status,
            OffsetDateTime from,
            OffsetDateTime to,
            String sort
    ) {
        requireUser(user);
        Specification<Event> spec = (root, query, cb) -> cb.conjunction();

        if (status != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("status"), status));
        }
        if (from != null) {
            spec = spec.and((root, query, cb) -> cb.greaterThanOrEqualTo(root.get("startsAt"), from));
        }
        if (to != null) {
            spec = spec.and((root, query, cb) -> cb.lessThanOrEqualTo(root.get("startsAt"), to));
        }
        if (Boolean.TRUE.equals(mine)) {
            if (user.role() != UserRole.ORGANIZER) {
                throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Only organizers can filter by mine=true.");
            }
            spec = spec.and((root, query, cb) -> cb.equal(root.get("organizerId"), user.userId()));
        }

        Sort parsedSort = parseSort(sort);
        List<Event> events = eventRepository.findAll(spec, parsedSort);
        return events.stream().map(this::toResponse).toList();
    }

    public EventResponse getEventById(AuthenticatedUser user, UUID eventId) {
        requireUser(user);
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found."));
        return toResponse(event);
    }

    public EventResponse createEvent(AuthenticatedUser user, CreateEventRequest request) {
        requireOrganizer(user);
        Event event = new Event(
                UUID.randomUUID(),
                request.title(),
                request.description(),
                request.location(),
                request.startsAt(),
                request.endsAt(),
                request.capacity(),
                user.userId()
        );
        eventRepository.save(event);
        return toResponse(event);
    }

    public EventResponse updateEvent(AuthenticatedUser user, UUID eventId, UpdateEventRequest request) {
        requireOrganizer(user);
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found."));

        if (!event.getOrganizerId().equals(user.userId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Only the organizer can update this event.");
        }
        if (event.getStatus() == EventStatus.CANCELED) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Canceled events cannot be updated.");
        }

        int activeRegistrations = registrationClient.getActiveRegistrationCount(eventId);
        if (request.capacity() < activeRegistrations) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Capacity cannot be lower than active registrations.");
        }

        event.setTitle(request.title());
        event.setDescription(request.description());
        event.setLocation(request.location());
        event.setStartsAt(request.startsAt());
        event.setEndsAt(request.endsAt());
        event.setCapacity(request.capacity());
        eventRepository.save(event);

        List<UUID> attendeeIds = registrationClient.getActiveAttendeeIds(eventId);
        String message = "Event '" + event.getTitle() + "' has been updated. Please check the new details.";
        notificationClient.notifyAttendees(eventId, attendeeIds, message, NotificationType.UPDATED);

        return toResponse(event);
    }

    public EventResponse cancelEvent(AuthenticatedUser user, UUID eventId) {
        requireOrganizer(user);
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found."));

        if (!event.getOrganizerId().equals(user.userId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Only the organizer can cancel this event.");
        }
        if (event.getStatus() == EventStatus.CANCELED) {
            return toResponse(event);
        }

        List<UUID> attendeeIds = registrationClient.getActiveAttendeeIds(eventId);
        event.setStatus(EventStatus.CANCELED);
        eventRepository.save(event);
        registrationClient.cancelRegistrations(eventId);

        String message = "Event '" + event.getTitle() + "' has been canceled.";
        notificationClient.notifyAttendees(eventId, attendeeIds, message, NotificationType.CANCELED);

        return toResponse(event);
    }

    public EventSummary getInternalSummary(UUID eventId) {
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found."));
        return new EventSummary(event.getId(), event.getStatus(), event.getCapacity());
    }

    private EventResponse toResponse(Event event) {
        return new EventResponse(
                event.getId(),
                event.getTitle(),
                event.getDescription(),
                event.getLocation(),
                event.getStartsAt(),
                event.getEndsAt(),
                event.getCapacity(),
                event.getOrganizerId(),
                event.getStatus(),
                event.getCreatedAt()
        );
    }

    private void requireUser(AuthenticatedUser user) {
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required.");
        }
    }

    private void requireOrganizer(AuthenticatedUser user) {
        requireUser(user);
        if (user.role() != UserRole.ORGANIZER) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Organizer role required.");
        }
    }

    private Sort parseSort(String sort) {
        if (sort == null || sort.isBlank()) {
            return Sort.unsorted();
        }
        String[] parts = sort.split(",", 2);
        if (parts.length != 2) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Sort must be in the format field,asc|desc.");
        }
        String field = parts[0];
        String direction = parts[1];
        if (!ALLOWED_SORT_FIELDS.contains(field)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Unsupported sort field: " + field);
        }
        Sort.Direction sortDirection;
        try {
            sortDirection = Sort.Direction.fromString(direction);
        } catch (IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Unsupported sort direction: " + direction);
        }
        return Sort.by(sortDirection, field);
    }
}

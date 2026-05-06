package com.example.event.web;

import com.example.event.security.AuthenticatedUser;
import com.example.event.security.SecurityUtils;
import com.example.event.service.EventService;
import com.example.event.web.dto.CreateEventRequest;
import com.example.event.web.dto.EventFilterRequest;
import com.example.event.web.dto.EventResponse;
import com.example.event.web.dto.UpdateEventRequest;
import jakarta.validation.Valid;
import java.util.List;
import java.util.UUID;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.ModelAttribute;

@RestController
public class EventController {

    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping("/api/events")
    public List<EventResponse> getEvents(
            @ModelAttribute EventFilterRequest filter
    ) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return eventService.getEvents(
                user,
                filter.getMine(),
                filter.getStatus(),
                filter.getFrom(),
                filter.getTo(),
            filter.getSort()
        );
    }

    @GetMapping("/api/events/{eventId}")
    public EventResponse getEventById(@PathVariable UUID eventId) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return eventService.getEventById(user, eventId);
    }

    @PostMapping("/api/events")
    @PreAuthorize("hasRole('ORGANIZER')")
    public EventResponse createEvent(@Valid @RequestBody CreateEventRequest request) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return eventService.createEvent(user, request);
    }

    @PutMapping("/api/events/{eventId}")
    @PreAuthorize("hasRole('ORGANIZER')")
    public EventResponse updateEvent(@PathVariable UUID eventId, @Valid @RequestBody UpdateEventRequest request) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return eventService.updateEvent(user, eventId, request);
    }

    @DeleteMapping("/api/events/{eventId}")
    @PreAuthorize("hasRole('ORGANIZER')")
    public EventResponse cancelEvent(@PathVariable UUID eventId) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return eventService.cancelEvent(user, eventId);
    }

    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse("ok");
    }

    public record HealthResponse(String status) {
    }
}

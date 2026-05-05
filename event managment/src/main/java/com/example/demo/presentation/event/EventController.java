package com.example.demo.presentation.event;

import com.example.demo.application.event.EventService;
import com.example.demo.common.ApiMessage;
import com.example.demo.presentation.event.dto.CreateEventRequest;
import com.example.demo.presentation.event.dto.UpdateEventRequest;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/events")
public class EventController {

    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping
    public ResponseEntity<ApiMessage> getAllEvents() {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(eventService.getAllEvents());
    }

    @GetMapping("/{eventId}")
    public ResponseEntity<ApiMessage> getEventById(@PathVariable Long eventId) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(eventService.getEventById(eventId));
    }

    @PostMapping
    public ResponseEntity<ApiMessage> createEvent(@Valid @RequestBody CreateEventRequest request) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(eventService.createEvent(request));
    }

    @PutMapping("/{eventId}")
    public ResponseEntity<ApiMessage> updateEvent(@PathVariable Long eventId, @Valid @RequestBody UpdateEventRequest request) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(eventService.updateEvent(eventId, request));
    }

    @PatchMapping("/{eventId}/cancel")
    public ResponseEntity<ApiMessage> cancelEvent(@PathVariable Long eventId) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(eventService.cancelEvent(eventId));
    }
}

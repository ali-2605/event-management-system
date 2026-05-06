package com.example.event.web;

import com.example.event.service.EventService;
import com.example.event.web.dto.EventSummary;
import java.util.UUID;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/internal/events")
public class InternalEventController {

    private final EventService eventService;

    public InternalEventController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping("/{eventId}")
    public EventSummary getEventSummary(@PathVariable UUID eventId) {
        return eventService.getInternalSummary(eventId);
    }
}

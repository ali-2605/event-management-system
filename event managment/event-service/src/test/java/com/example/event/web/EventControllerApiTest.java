package com.example.event.web;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.example.event.domain.EventStatus;
import com.example.event.security.JwtAuthenticationFilter;
import com.example.event.security.ServiceTokenFilter;
import com.example.event.service.EventService;
import com.example.event.web.dto.EventResponse;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.server.ResponseStatusException;

@WebMvcTest(EventController.class)
@AutoConfigureMockMvc(addFilters = false)
@Import(GlobalExceptionHandler.class)
class EventControllerApiTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EventService eventService;

    @MockBean
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @MockBean
    private ServiceTokenFilter serviceTokenFilter;

    @Test
    void healthReturnsOk() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("ok"));
    }

    @Test
    void createEventWithoutTitleReturnsValidationError() throws Exception {
        String request = """
                {
                  "title": "",
                  "description": "desc",
                  "location": "Room 1",
                  "startsAt": "2026-06-01T10:00:00Z",
                  "endsAt": "2026-06-01T12:00:00Z",
                  "capacity": 50
                }
                """;

        mockMvc.perform(post("/api/events")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(request))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.title").value(containsString("must not be blank")));
    }

    @Test
    void getUnknownEventReturnsNotFoundErrorBody() throws Exception {
        UUID eventId = UUID.fromString("33333333-3333-3333-3333-333333333333");
        when(eventService.getEventById(any(), eq(eventId)))
                .thenThrow(new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found."));

        mockMvc.perform(get("/api/events/{id}", eventId))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.error").value(containsString("Event not found")));
    }

    @Test
    void getEventByIdSuccessReturnsPayload() throws Exception {
        UUID eventId = UUID.fromString("33333333-3333-3333-3333-333333333333");
        when(eventService.getEventById(any(), eq(eventId))).thenReturn(new EventResponse(
                eventId,
                "Tech Meetup",
                "desc",
                "Room 1",
                OffsetDateTime.parse("2026-06-01T10:00:00Z"),
                OffsetDateTime.parse("2026-06-01T12:00:00Z"),
                50,
                UUID.fromString("44444444-4444-4444-4444-444444444444"),
                EventStatus.ACTIVE,
                OffsetDateTime.parse("2026-05-01T10:00:00Z")
        ));

        mockMvc.perform(get("/api/events/{id}", eventId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.title").value("Tech Meetup"));
    }
}

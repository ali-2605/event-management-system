package com.example.event.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.example.event.data.EventRepository;
import com.example.event.domain.Event;
import com.example.event.domain.EventStatus;
import com.example.event.domain.NotificationType;
import com.example.event.security.AuthenticatedUser;
import com.example.event.security.UserRole;
import com.example.event.service.client.NotificationClient;
import com.example.event.service.client.RegistrationClient;
import com.example.event.web.dto.UpdateEventRequest;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@ExtendWith(MockitoExtension.class)
class EventServiceTest {

    @Mock
    private EventRepository eventRepository;

    @Mock
    private RegistrationClient registrationClient;

    @Mock
    private NotificationClient notificationClient;

    @InjectMocks
    private EventService eventService;

    private final UUID organizerId = UUID.fromString("11111111-1111-1111-1111-111111111111");
    private final UUID eventId = UUID.fromString("22222222-2222-2222-2222-222222222222");
    private Event existingEvent;

    @BeforeEach
    void setUp() {
        existingEvent = new Event(
                eventId,
                "Tech Meetup",
                "Quarterly meetup",
                "Cairo",
                OffsetDateTime.parse("2026-06-01T10:00:00Z"),
                OffsetDateTime.parse("2026-06-01T12:00:00Z"),
                100,
                organizerId
        );
    }

    @Test
    void getEventsMineByAttendeeReturnsForbidden() {
        AuthenticatedUser attendee = new AuthenticatedUser(UUID.randomUUID(), UserRole.ATTENDEE);

        assertThatThrownBy(() -> eventService.getEvents(attendee, true, null, null, null, null))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
                    assertThat(statusEx.getReason()).contains("Only organizers");
                });
    }

    @Test
    void updateEventWithLowerCapacityThanActiveRegistrationsReturnsConflict() {
        AuthenticatedUser organizer = new AuthenticatedUser(organizerId, UserRole.ORGANIZER);
        UpdateEventRequest request = new UpdateEventRequest(
                "Tech Meetup Updated",
                "Updated",
                "Alex",
                OffsetDateTime.parse("2026-06-02T10:00:00Z"),
                OffsetDateTime.parse("2026-06-02T12:00:00Z"),
                5
        );

        when(eventRepository.findById(eventId)).thenReturn(Optional.of(existingEvent));
        when(registrationClient.getActiveRegistrationCount(eventId)).thenReturn(10);

        assertThatThrownBy(() -> eventService.updateEvent(organizer, eventId, request))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
                    assertThat(statusEx.getReason()).contains("Capacity cannot be lower");
                });
    }

    @Test
    void cancelEventNotifiesAttendeesAndCancelsRegistrations() {
        AuthenticatedUser organizer = new AuthenticatedUser(organizerId, UserRole.ORGANIZER);
        List<UUID> attendeeIds = List.of(UUID.randomUUID(), UUID.randomUUID());

        when(eventRepository.findById(eventId)).thenReturn(Optional.of(existingEvent));
        when(registrationClient.getActiveAttendeeIds(eventId)).thenReturn(attendeeIds);

        var response = eventService.cancelEvent(organizer, eventId);

        assertThat(response.status()).isEqualTo(EventStatus.CANCELED);
        verify(eventRepository).save(existingEvent);
        verify(registrationClient).cancelRegistrations(eventId);
        verify(notificationClient).notifyAttendees(eq(eventId), eq(attendeeIds), any(), eq(NotificationType.CANCELED));
    }

    @Test
    void getEventsWithInvalidSortDirectionReturnsBadRequest() {
        AuthenticatedUser organizer = new AuthenticatedUser(organizerId, UserRole.ORGANIZER);

        assertThatThrownBy(() -> eventService.getEvents(organizer, false, null, null, null, "startsAt,sideways"))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
                    assertThat(statusEx.getReason()).contains("Unsupported sort direction");
                });
    }
}

package com.example.registration.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.example.registration.data.RegistrationRepository;
import com.example.registration.domain.Registration;
import com.example.registration.domain.RegistrationStatus;
import com.example.registration.security.AuthenticatedUser;
import com.example.registration.security.UserRole;
import com.example.registration.service.client.EventClient;
import com.example.registration.service.client.EventStatus;
import com.example.registration.service.client.EventSummary;
import com.example.registration.web.dto.CreateRegistrationRequest;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@ExtendWith(MockitoExtension.class)
class RegistrationServiceTest {

    @Mock
    private RegistrationRepository registrationRepository;

    @Mock
    private EventClient eventClient;

    @InjectMocks
    private RegistrationService registrationService;

    @Test
    void registerForCanceledEventReturnsConflict() {
        UUID eventId = UUID.fromString("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa");
        AuthenticatedUser attendee = new AuthenticatedUser(UUID.randomUUID(), UserRole.ATTENDEE);

        when(eventClient.getEventSummary(eventId)).thenReturn(new EventSummary(eventId, EventStatus.CANCELED, 50));

        assertThatThrownBy(() -> registrationService.registerForEvent(attendee, new CreateRegistrationRequest(eventId)))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
                    assertThat(statusEx.getReason()).contains("canceled event");
                });
    }

    @Test
    void registerWhenAlreadyActiveReturnsConflict() {
        UUID eventId = UUID.fromString("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb");
        UUID attendeeId = UUID.fromString("cccccccc-cccc-cccc-cccc-cccccccccccc");
        AuthenticatedUser attendee = new AuthenticatedUser(attendeeId, UserRole.ATTENDEE);

        Registration existing = new Registration(UUID.randomUUID(), eventId, attendeeId);
        existing.setStatus(RegistrationStatus.ACTIVE);

        when(eventClient.getEventSummary(eventId)).thenReturn(new EventSummary(eventId, EventStatus.ACTIVE, 50));
        when(registrationRepository.countByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE)).thenReturn(1L);
        when(registrationRepository.findByEventIdAndAttendeeId(eventId, attendeeId)).thenReturn(Optional.of(existing));

        assertThatThrownBy(() -> registrationService.registerForEvent(attendee, new CreateRegistrationRequest(eventId)))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
                    assertThat(statusEx.getReason()).contains("already registered");
                });
    }

    @Test
    void cancelOtherUsersRegistrationReturnsForbidden() {
        UUID registrationId = UUID.fromString("dddddddd-dddd-dddd-dddd-dddddddddddd");
        UUID owner = UUID.fromString("eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee");
        Registration registration = new Registration(registrationId, UUID.randomUUID(), owner);

        when(registrationRepository.findById(registrationId)).thenReturn(Optional.of(registration));

        AuthenticatedUser anotherUser = new AuthenticatedUser(UUID.randomUUID(), UserRole.ATTENDEE);

        assertThatThrownBy(() -> registrationService.cancelRegistration(anotherUser, registrationId))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
                    assertThat(statusEx.getReason()).contains("your own registration");
                });
    }

    @Test
    void cancelRegistrationsForEventCancelsAllActive() {
        UUID eventId = UUID.fromString("ffffffff-ffff-ffff-ffff-ffffffffffff");
        List<Registration> active = List.of(
                new Registration(UUID.randomUUID(), eventId, UUID.randomUUID()),
                new Registration(UUID.randomUUID(), eventId, UUID.randomUUID())
        );
        when(registrationRepository.findAllByEventIdAndStatus(eventId, RegistrationStatus.ACTIVE)).thenReturn(active);

        int canceled = registrationService.cancelRegistrationsForEvent(eventId);

        assertThat(canceled).isEqualTo(2);
        verify(registrationRepository).saveAll(active);
    }
}

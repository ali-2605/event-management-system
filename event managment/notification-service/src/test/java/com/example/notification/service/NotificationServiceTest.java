package com.example.notification.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.example.notification.data.NotificationRepository;
import com.example.notification.domain.Notification;
import com.example.notification.domain.NotificationType;
import com.example.notification.security.AuthenticatedUser;
import com.example.notification.security.UserRole;
import com.example.notification.web.dto.NotifyAttendeesRequest;
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
class NotificationServiceTest {

    @Mock
    private NotificationRepository notificationRepository;

    @InjectMocks
    private NotificationService notificationService;

    @Test
    void getNotificationsWithoutUserReturnsUnauthorized() {
        assertThatThrownBy(() -> notificationService.getNotifications(null, null, null, null, null, null))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
                    assertThat(statusEx.getReason()).contains("Authentication required");
                });
    }

    @Test
    void toggleReadForOtherUserReturnsForbidden() {
        UUID notificationId = UUID.fromString("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee");
        Notification notification = new Notification(
                notificationId,
                UUID.fromString("11111111-1111-1111-1111-111111111111"),
                UUID.randomUUID(),
                "message",
                NotificationType.UPDATED
        );
        when(notificationRepository.findById(notificationId)).thenReturn(Optional.of(notification));

        AuthenticatedUser anotherUser = new AuthenticatedUser(
                UUID.fromString("22222222-2222-2222-2222-222222222222"),
                UserRole.ATTENDEE
        );

        assertThatThrownBy(() -> notificationService.toggleRead(anotherUser, notificationId))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
                    assertThat(statusEx.getReason()).contains("own notifications");
                });
    }

    @Test
    void createNotificationsWithEmptyAttendeesReturnsZero() {
        NotifyAttendeesRequest request = new NotifyAttendeesRequest(
                UUID.randomUUID(),
                List.of(),
                NotificationType.UPDATED,
                "message"
        );

        int created = notificationService.createNotifications(request);

        assertThat(created).isZero();
    }

    @Test
    void getNotificationsWithInvalidSortFieldReturnsBadRequest() {
        AuthenticatedUser attendee = new AuthenticatedUser(UUID.randomUUID(), UserRole.ATTENDEE);

        assertThatThrownBy(() -> notificationService.getNotifications(attendee, null, null, null, null, "id,asc"))
                .isInstanceOf(ResponseStatusException.class)
                .satisfies(ex -> {
                    ResponseStatusException statusEx = (ResponseStatusException) ex;
                    assertThat(statusEx.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
                    assertThat(statusEx.getReason()).contains("Unsupported sort field");
                });
    }

    @Test
    void toggleReadTogglesAndSavesNotification() {
        UUID attendeeId = UUID.fromString("33333333-3333-3333-3333-333333333333");
        UUID notificationId = UUID.fromString("44444444-4444-4444-4444-444444444444");
        Notification notification = new Notification(
                notificationId,
                attendeeId,
                UUID.randomUUID(),
                "message",
                NotificationType.UPDATED
        );
        when(notificationRepository.findById(notificationId)).thenReturn(Optional.of(notification));

        var response = notificationService.toggleRead(new AuthenticatedUser(attendeeId, UserRole.ATTENDEE), notificationId);

        assertThat(response.read()).isTrue();
        verify(notificationRepository).save(notification);
    }
}

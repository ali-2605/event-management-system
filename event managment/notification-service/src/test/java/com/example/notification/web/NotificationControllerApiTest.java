package com.example.notification.web;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.example.notification.domain.NotificationType;
import com.example.notification.security.JwtAuthenticationFilter;
import com.example.notification.security.ServiceTokenFilter;
import com.example.notification.service.NotificationService;
import com.example.notification.web.dto.NotificationResponse;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.server.ResponseStatusException;

@WebMvcTest(NotificationController.class)
@AutoConfigureMockMvc(addFilters = false)
@Import(GlobalExceptionHandler.class)
class NotificationControllerApiTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private NotificationService notificationService;

    @MockBean
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @MockBean
    private ServiceTokenFilter serviceTokenFilter;

    @Test
    void getNotificationsReturnsPayload() throws Exception {
        when(notificationService.getNotifications(any(), any(), any(), any(), any(), any())).thenReturn(List.of(
                new NotificationResponse(
                        UUID.fromString("11111111-2222-3333-4444-555555555555"),
                        UUID.fromString("aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"),
                        UUID.fromString("bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"),
                        "Event updated",
                        NotificationType.UPDATED,
                        false,
                        OffsetDateTime.parse("2026-05-01T10:00:00Z")
                )
        ));

        mockMvc.perform(get("/api/notifications"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].message").value("Event updated"));
    }

    @Test
    void toggleReadNotFoundReturnsErrorBody() throws Exception {
        UUID notificationId = UUID.fromString("11111111-2222-3333-4444-555555555555");
        when(notificationService.toggleRead(any(), eq(notificationId)))
                .thenThrow(new ResponseStatusException(HttpStatus.NOT_FOUND, "Notification not found."));

        mockMvc.perform(patch("/api/notifications/{id}", notificationId))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.error").value(containsString("not found")));
    }

    @Test
    void healthReturnsOk() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("ok"));
    }
}

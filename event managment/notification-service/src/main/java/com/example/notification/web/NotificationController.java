package com.example.notification.web;

import java.util.List;
import java.util.UUID;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.notification.security.AuthenticatedUser;
import com.example.notification.security.SecurityUtils;
import com.example.notification.service.NotificationService;
import com.example.notification.web.dto.NotificationFilterRequest;
import com.example.notification.web.dto.NotificationResponse;

@RestController
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping("/api/notifications")
    @PreAuthorize("hasRole('ATTENDEE')")
    public List<NotificationResponse> getNotifications(
            @ModelAttribute NotificationFilterRequest filter
    ) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return notificationService.getNotifications(
                user,
                filter.getSeen(),
                filter.getFrom(),
                filter.getTo(),
                filter.getEventId(),
                filter.getSort()
        );
    }

    @PatchMapping("/api/notifications/{notificationId}")
    @PreAuthorize("hasRole('ATTENDEE')")
    public NotificationResponse toggleRead(@PathVariable UUID notificationId) {
        AuthenticatedUser user = SecurityUtils.currentUser();
        return notificationService.toggleRead(user, notificationId);
    }

    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse("ok");
    }

    public record HealthResponse(String status) {
    }
}

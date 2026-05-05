package com.example.demo.presentation.notification;

import com.example.demo.application.notification.NotificationService;
import com.example.demo.common.ApiMessage;
import com.example.demo.domain.notification.NotificationType;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping("/events/{eventId}/preview")
    public ResponseEntity<ApiMessage> previewNotification(
            @PathVariable Long eventId,
            @RequestParam NotificationType type
    ) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(notificationService.previewNotification(eventId, type));
    }
}

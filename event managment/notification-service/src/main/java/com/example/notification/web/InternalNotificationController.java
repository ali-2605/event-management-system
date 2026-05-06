package com.example.notification.web;

import com.example.notification.service.NotificationService;
import com.example.notification.web.dto.NotifyAttendeesRequest;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/internal/notifications")
public class InternalNotificationController {

    private final NotificationService notificationService;

    public InternalNotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @PostMapping("/event")
    public int notifyAttendees(@Valid @RequestBody NotifyAttendeesRequest request) {
        return notificationService.createNotifications(request);
    }
}

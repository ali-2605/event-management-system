package com.example.demo.application.notification;

import com.example.demo.common.ApiMessage;
import com.example.demo.domain.notification.NotificationType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

    private static final Logger LOGGER = LoggerFactory.getLogger(NotificationService.class);

    public ApiMessage previewNotification(Long eventId, NotificationType type) {
        LOGGER.info("Notification scaffold invoked for event {} with type {}", eventId, type);
        return new ApiMessage("Notification scaffolded. Implement attendee lookup and delivery for " + type + " here.");
    }
}

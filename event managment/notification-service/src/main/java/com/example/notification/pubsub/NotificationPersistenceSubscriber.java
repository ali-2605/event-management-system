package com.example.notification.pubsub;

import com.example.notification.data.NotificationRepository;
import com.example.notification.domain.Notification;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Component;

@Component
public class NotificationPersistenceSubscriber implements NotificationSubscriber {

    private final NotificationRepository notificationRepository;

    public NotificationPersistenceSubscriber(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    @Override
    public void onNotification(NotificationEvent event) {
        if (event == null || event.attendeeIds().isEmpty()) {
            return;
        }
        List<Notification> notifications = event.attendeeIds().stream()
                .map(attendeeId -> new Notification(
                        UUID.randomUUID(),
                        attendeeId,
                        event.eventId(),
                        event.message(),
                        event.type()
                ))
                .toList();
        notificationRepository.saveAll(notifications);
    }
}

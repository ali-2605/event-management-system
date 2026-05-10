package com.example.notification.pubsub;

import java.util.List;
import org.springframework.stereotype.Component;

@Component
public class NotificationPublisher {

    private final List<NotificationSubscriber> subscribers;

    public NotificationPublisher(List<NotificationSubscriber> subscribers) {
        this.subscribers = List.copyOf(subscribers);
    }

    public void publish(NotificationEvent event) {
        for (NotificationSubscriber subscriber : subscribers) {
            subscriber.onNotification(event);
        }
    }
}

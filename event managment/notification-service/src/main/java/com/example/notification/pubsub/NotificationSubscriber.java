package com.example.notification.pubsub;

public interface NotificationSubscriber {
    void onNotification(NotificationEvent event);
}

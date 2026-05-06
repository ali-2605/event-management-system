package com.example.notification.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(name = "notifications")
public class Notification {

    @Id
    @Column(nullable = false, updatable = false, columnDefinition = "uuid")
    private UUID id;

    @Column(name = "attendee_id", nullable = false, columnDefinition = "uuid")
    private UUID attendeeId;

    @Column(name = "event_id", nullable = false, columnDefinition = "uuid")
    private UUID eventId;

    @Column(nullable = false, length = 500)
    private String message;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private NotificationType type;

    @Column(nullable = false)
    private boolean read = false;

    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt = OffsetDateTime.now();

    protected Notification() {
    }

    public Notification(UUID id, UUID attendeeId, UUID eventId, String message, NotificationType type) {
        this.id = id;
        this.attendeeId = attendeeId;
        this.eventId = eventId;
        this.message = message;
        this.type = type;
    }

    public UUID getId() {
        return id;
    }

    public UUID getAttendeeId() {
        return attendeeId;
    }

    public UUID getEventId() {
        return eventId;
    }

    public String getMessage() {
        return message;
    }

    public NotificationType getType() {
        return type;
    }

    public boolean isRead() {
        return read;
    }

    public void toggleRead() {
        this.read = !this.read;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }
}

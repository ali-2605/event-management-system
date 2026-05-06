package com.example.registration.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Table(
        name = "registrations",
        uniqueConstraints = @UniqueConstraint(name = "uk_registration_attendee_event", columnNames = {"attendee_id", "event_id"})
)
public class Registration {

    @Id
    @Column(nullable = false, updatable = false, columnDefinition = "uuid")
    private UUID id;

    @Column(name = "event_id", nullable = false, columnDefinition = "uuid")
    private UUID eventId;

    @Column(name = "attendee_id", nullable = false, columnDefinition = "uuid")
    private UUID attendeeId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private RegistrationStatus status = RegistrationStatus.ACTIVE;

    @Column(nullable = false, updatable = false)
    private OffsetDateTime registeredAt = OffsetDateTime.now();

    @Column
    private OffsetDateTime canceledAt;

    protected Registration() {
    }

    public Registration(UUID id, UUID eventId, UUID attendeeId) {
        this.id = id;
        this.eventId = eventId;
        this.attendeeId = attendeeId;
    }

    public UUID getId() {
        return id;
    }

    public UUID getEventId() {
        return eventId;
    }

    public void setEventId(UUID eventId) {
        this.eventId = eventId;
    }

    public UUID getAttendeeId() {
        return attendeeId;
    }

    public void setAttendeeId(UUID attendeeId) {
        this.attendeeId = attendeeId;
    }

    public RegistrationStatus getStatus() {
        return status;
    }

    public void setStatus(RegistrationStatus status) {
        this.status = status;
    }

    public OffsetDateTime getRegisteredAt() {
        return registeredAt;
    }

    public OffsetDateTime getCanceledAt() {
        return canceledAt;
    }

    public void setCanceledAt(OffsetDateTime canceledAt) {
        this.canceledAt = canceledAt;
    }

    public void reactivate() {
        this.status = RegistrationStatus.ACTIVE;
        this.canceledAt = null;
    }

    public void cancel() {
        this.status = RegistrationStatus.CANCELED;
        this.canceledAt = OffsetDateTime.now();
    }
}

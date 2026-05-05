package com.example.demo.domain.registration;

import com.example.demo.domain.auth.UserAccount;
import com.example.demo.domain.event.Event;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.OffsetDateTime;

@Entity
@Table(
        name = "registrations",
        uniqueConstraints = @UniqueConstraint(
                name = "uk_registration_attendee_event",
                columnNames = {"attendee_id", "event_id"}
        )
)
public class Registration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "attendee_id", nullable = false)
    private UserAccount attendee;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "event_id", nullable = false)
    private Event event;

    @Column(nullable = false, updatable = false)
    private OffsetDateTime registeredAt = OffsetDateTime.now();

    protected Registration() {
    }

    public Long getId() {
        return id;
    }

    public UserAccount getAttendee() {
        return attendee;
    }

    public void setAttendee(UserAccount attendee) {
        this.attendee = attendee;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public OffsetDateTime getRegisteredAt() {
        return registeredAt;
    }
}

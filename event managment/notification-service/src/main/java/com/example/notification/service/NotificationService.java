package com.example.notification.service;

import com.example.notification.data.NotificationRepository;
import com.example.notification.domain.Notification;
import com.example.notification.security.AuthenticatedUser;
import com.example.notification.security.UserRole;
import com.example.notification.pubsub.NotificationEvent;
import com.example.notification.pubsub.NotificationPublisher;
import com.example.notification.web.dto.NotificationResponse;
import com.example.notification.web.dto.NotifyAttendeesRequest;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class NotificationService {

    private static final Set<String> ALLOWED_SORT_FIELDS = Set.of("createdAt");

    private final NotificationRepository notificationRepository;
    private final NotificationPublisher notificationPublisher;

    public NotificationService(NotificationRepository notificationRepository, NotificationPublisher notificationPublisher) {
        this.notificationRepository = notificationRepository;
        this.notificationPublisher = notificationPublisher;
    }

    public List<NotificationResponse> getNotifications(
            AuthenticatedUser user,
            Boolean seen,
            OffsetDateTime from,
            OffsetDateTime to,
            UUID eventId,
            String sort
    ) {
        requireAttendee(user);
        Specification<Notification> spec = Specification.where(attendeeSpec(user.userId()));

        if (seen != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("read"), seen));
        }
        if (from != null) {
            spec = spec.and((root, query, cb) -> cb.greaterThanOrEqualTo(root.get("createdAt"), from));
        }
        if (to != null) {
            spec = spec.and((root, query, cb) -> cb.lessThanOrEqualTo(root.get("createdAt"), to));
        }
        if (eventId != null) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("eventId"), eventId));
        }

        Sort parsedSort = parseSort(sort);
        List<Notification> notifications = notificationRepository.findAll(spec, parsedSort);
        return notifications.stream().map(this::toResponse).toList();
    }

    public NotificationResponse toggleRead(AuthenticatedUser user, UUID notificationId) {
        requireAttendee(user);
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Notification not found."));
        if (!notification.getAttendeeId().equals(user.userId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You can only modify your own notifications.");
        }
        notification.toggleRead();
        notificationRepository.save(notification);
        return toResponse(notification);
    }

    public int createNotifications(NotifyAttendeesRequest request) {
        if (request == null || request.attendeeIds() == null || request.attendeeIds().isEmpty()) {
            return 0;
        }
        NotificationEvent event = new NotificationEvent(
            request.eventId(),
            request.attendeeIds(),
            request.type(),
            request.message()
        );
        notificationPublisher.publish(event);
        return event.attendeeIds().size();
    }

    private Specification<Notification> attendeeSpec(UUID attendeeId) {
        return (root, query, cb) -> cb.equal(root.get("attendeeId"), attendeeId);
    }

    private NotificationResponse toResponse(Notification notification) {
        return new NotificationResponse(
                notification.getId(),
                notification.getAttendeeId(),
                notification.getEventId(),
                notification.getMessage(),
                notification.getType(),
                notification.isRead(),
                notification.getCreatedAt()
        );
    }

    private void requireAttendee(AuthenticatedUser user) {
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication required.");
        }
        if (user.role() != UserRole.ATTENDEE) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Attendee role required.");
        }
    }

    private Sort parseSort(String sort) {
        if (sort == null || sort.isBlank()) {
            return Sort.unsorted();
        }
        String[] parts = sort.split(",", 2);
        if (parts.length != 2) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Sort must be in the format field,asc|desc.");
        }
        String field = parts[0];
        String direction = parts[1];
        if (!ALLOWED_SORT_FIELDS.contains(field)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Unsupported sort field: " + field);
        }
        Sort.Direction sortDirection;
        try {
            sortDirection = Sort.Direction.fromString(direction);
        } catch (IllegalArgumentException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Unsupported sort direction: " + direction);
        }
        return Sort.by(sortDirection, field);
    }
}

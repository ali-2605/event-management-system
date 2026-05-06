package com.example.registration.data;

import com.example.registration.domain.Registration;
import com.example.registration.domain.RegistrationStatus;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegistrationRepository extends JpaRepository<Registration, UUID> {

    Optional<Registration> findByEventIdAndAttendeeId(UUID eventId, UUID attendeeId);

    long countByEventIdAndStatus(UUID eventId, RegistrationStatus status);

    List<Registration> findAllByEventIdAndStatus(UUID eventId, RegistrationStatus status);

    List<Registration> findAllByEventId(UUID eventId);

    List<Registration> findAllByAttendeeId(UUID attendeeId);
}

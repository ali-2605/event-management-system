package com.example.demo.data.registration;

import com.example.demo.domain.registration.Registration;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {

    boolean existsByEvent_IdAndAttendee_Id(Long eventId, Long attendeeId);

    List<Registration> findAllByEvent_Id(Long eventId);
}

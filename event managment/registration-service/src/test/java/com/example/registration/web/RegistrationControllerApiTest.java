package com.example.registration.web;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.example.registration.security.JwtAuthenticationFilter;
import com.example.registration.security.ServiceTokenFilter;
import com.example.registration.service.RegistrationService;
import com.example.registration.web.dto.RegistrationResponse;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.server.ResponseStatusException;

@WebMvcTest(RegistrationController.class)
@AutoConfigureMockMvc(addFilters = false)
@Import(GlobalExceptionHandler.class)
class RegistrationControllerApiTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private RegistrationService registrationService;

    @MockBean
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @MockBean
    private ServiceTokenFilter serviceTokenFilter;

    @Test
    void registerWithoutEventIdReturnsValidationError() throws Exception {
        String request = "{}";

        mockMvc.perform(post("/api/registrations")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(request))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.eventId").value(containsString("must not be null")));
    }

    @Test
    void cancelWithForbiddenErrorReturnsJsonMessage() throws Exception {
        UUID registrationId = UUID.fromString("11111111-2222-3333-4444-555555555555");
        when(registrationService.cancelRegistration(any(), eq(registrationId)))
                .thenThrow(new ResponseStatusException(HttpStatus.FORBIDDEN, "You can only cancel your own registration."));

        mockMvc.perform(delete("/api/registrations/{id}", registrationId))
                .andExpect(status().isForbidden())
                .andExpect(jsonPath("$.error").value(containsString("own registration")));
    }

    @Test
    void cancelSuccessReturnsResponse() throws Exception {
        UUID registrationId = UUID.fromString("11111111-2222-3333-4444-555555555555");
        when(registrationService.cancelRegistration(any(), eq(registrationId))).thenReturn(new RegistrationResponse(
                registrationId,
                UUID.randomUUID(),
                UUID.randomUUID(),
                com.example.registration.domain.RegistrationStatus.CANCELED,
                OffsetDateTime.parse("2026-05-01T10:00:00Z"),
                OffsetDateTime.parse("2026-05-02T10:00:00Z")
        ));

        mockMvc.perform(delete("/api/registrations/{id}", registrationId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("CANCELED"));
    }
}

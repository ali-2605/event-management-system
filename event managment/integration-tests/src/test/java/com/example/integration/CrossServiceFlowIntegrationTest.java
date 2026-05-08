package com.example.integration;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import static org.junit.jupiter.api.Assertions.*;

public class CrossServiceFlowIntegrationTest {

    private final RestTemplate rest = new RestTemplate();
    private final ObjectMapper mapper = new ObjectMapper();

    private ResponseEntity<String> safePost(String url, String body, HttpHeaders headers) {
        try {
            HttpEntity<String> entity = new HttpEntity<>(body, headers);
            return rest.exchange(url, HttpMethod.POST, entity, String.class);
        } catch (HttpClientErrorException ex) {
            return ResponseEntity.status(ex.getRawStatusCode()).body(ex.getResponseBodyAsString());
        }
    }

    private ResponseEntity<String> safeGet(String url, HttpHeaders headers) {
        try {
            HttpEntity<Void> entity = new HttpEntity<>(headers);
            return rest.exchange(url, HttpMethod.GET, entity, String.class);
        } catch (HttpClientErrorException ex) {
            return ResponseEntity.status(ex.getRawStatusCode()).body(ex.getResponseBodyAsString());
        }
    }

    @Test
    public void userAuthenticationFlow() throws Exception {
        String email = "itest.user+auth@example.com";
        String password = "Password1!";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String registerPayload = mapper.createObjectNode()
                .put("email", email)
                .put("password", password)
                               .put("name", "Integration Test User")
                               .put("role", "ATTENDEE")
                .toString();

        ResponseEntity<String> regResp = safePost("http://localhost:8081/api/auth/register", registerPayload, headers);
        assertTrue(regResp.getStatusCode().is2xxSuccessful() || regResp.getStatusCode().value() == 201,
                "Register should return 2xx or 201 but was: " + regResp.getStatusCodeValue());

        String loginPayload = mapper.createObjectNode()
                .put("email", email)
                .put("password", password)
                .toString();

        ResponseEntity<String> loginResp = safePost("http://localhost:8081/api/auth/login", loginPayload, headers);
        assertEquals(200, loginResp.getStatusCodeValue(), "Login should return 200");
        assertNotNull(loginResp.getBody());
        String body = loginResp.getBody();
        assertTrue(body.contains("token") || body.contains("accessToken") || body.contains("jwt"),
                "Login response should contain a token-like field: " + body);
    }

    @Test
    public void loginFailureWithInvalidCredentials() throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String loginPayload = mapper.createObjectNode()
                .put("email", "nonexistent+login@example.com")
                .put("password", "WrongPassword")
                .toString();

        ResponseEntity<String> resp = safePost("http://localhost:8081/api/auth/login", loginPayload, headers);
        assertTrue(resp.getStatusCode().value() == 401 || resp.getStatusCode().value() == 403,
                "Invalid credentials should return 401 or 403 but was: " + resp.getStatusCodeValue());
    }

    @Test
    public void duplicateEmailRegistrationFails() throws Exception {
        String email = "itest.duplicate@example.com";
        String name = "Duplicate Test User";
        String role = "ATTENDEE";
        String password = "Password1!";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String registerPayload = mapper.createObjectNode()
                .put("email", email)
                .put("password", password)
                .put("name", name)
                .put("role", role)
                .toString();

        ResponseEntity<String> first = safePost("http://localhost:8081/api/auth/register", registerPayload, headers);
        assertTrue(first.getStatusCode().is2xxSuccessful() || first.getStatusCodeValue() == 201);

        ResponseEntity<String> second = safePost("http://localhost:8081/api/auth/register", registerPayload, headers);
        assertTrue(second.getStatusCodeValue() == 409 || second.getStatusCode().is4xxClientError(),
                "Duplicate registration should return 409 or other 4xx but was: " + second.getStatusCodeValue());
    }

    @Test
    public void unauthenticatedAccessDenied() throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String payload = mapper.createObjectNode()
                .put("eventId", 123)
                .toString();

        // POST to registrations endpoint without Authorization should be rejected
        ResponseEntity<String> resp = safePost("http://localhost:8083/api/registrations", payload, headers);
        assertTrue(resp.getStatusCodeValue() == 401 || resp.getStatusCodeValue() == 403,
                "Unauthenticated access should be denied with 401/403 but was: " + resp.getStatusCodeValue());
    }

    @Test
    public void registrationValidationFails() throws Exception {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // missing eventId -> expect 400
        String badPayload = mapper.createObjectNode()
                .put("notes", "no event id")
                .toString();

        ResponseEntity<String> resp = safePost("http://localhost:8083/api/registrations", badPayload, headers);
        assertTrue(resp.getStatusCodeValue() == 400 || resp.getStatusCode().is4xxClientError(),
                "Invalid registration payload should return 400/4xx but was: " + resp.getStatusCodeValue());
    }

    @Test
    public void healthChecksAreAccessible() throws Exception {
        ResponseEntity<String> a = safeGet("http://localhost:8081/health", new HttpHeaders());
        ResponseEntity<String> b = safeGet("http://localhost:8082/health", new HttpHeaders());
        ResponseEntity<String> c = safeGet("http://localhost:8083/health", new HttpHeaders());
        ResponseEntity<String> d = safeGet("http://localhost:8084/health", new HttpHeaders());

        assertTrue(a.getStatusCode().is2xxSuccessful(), "Auth service health should be 2xx");
        assertTrue(b.getStatusCode().is2xxSuccessful(), "Event service health should be 2xx");
        assertTrue(c.getStatusCode().is2xxSuccessful(), "Registration service health should be 2xx");
        assertTrue(d.getStatusCode().is2xxSuccessful(), "Notification service health should be 2xx");
    }
}

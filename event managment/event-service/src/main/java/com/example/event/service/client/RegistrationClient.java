package com.example.event.service.client;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class RegistrationClient {

    private final RestTemplate restTemplate;
    private final String baseUrl;
    private final String serviceToken;

    public RegistrationClient(
            RestTemplate restTemplate,
            @Value("${services.registration.base-url}") String baseUrl,
            @Value("${security.service-token}") String serviceToken
    ) {
        this.restTemplate = restTemplate;
        this.baseUrl = baseUrl;
        this.serviceToken = serviceToken;
    }

    public List<UUID> getActiveAttendeeIds(UUID eventId) {
        String url = baseUrl + "/internal/registrations/event/" + eventId + "/attendees";
        ResponseEntity<UUID[]> response = restTemplate.exchange(url, HttpMethod.GET, serviceEntity(), UUID[].class);
        UUID[] body = response.getBody();
        if (body == null) {
            return Collections.emptyList();
        }
        return Arrays.asList(body);
    }

    public int getActiveRegistrationCount(UUID eventId) {
        String url = baseUrl + "/internal/registrations/event/" + eventId + "/count";
        ResponseEntity<Integer> response = restTemplate.exchange(url, HttpMethod.GET, serviceEntity(), Integer.class);
        Integer body = response.getBody();
        return body == null ? 0 : body;
    }

    public void cancelRegistrations(UUID eventId) {
        String url = baseUrl + "/internal/registrations/event/" + eventId + "/cancel";
        restTemplate.exchange(url, HttpMethod.POST, serviceEntity(), Void.class);
    }

    private HttpEntity<Void> serviceEntity() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Service-Token", serviceToken);
        return new HttpEntity<>(headers);
    }
}

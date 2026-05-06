package com.example.registration.service.client;

import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

@Component
public class EventClient {

    private final RestTemplate restTemplate;
    private final String baseUrl;
    private final String serviceToken;

    public EventClient(
            RestTemplate restTemplate,
            @Value("${services.event.base-url}") String baseUrl,
            @Value("${security.service-token}") String serviceToken
    ) {
        this.restTemplate = restTemplate;
        this.baseUrl = baseUrl;
        this.serviceToken = serviceToken;
    }

    public EventSummary getEventSummary(UUID eventId) {
        String url = baseUrl + "/internal/events/" + eventId;
        try {
            ResponseEntity<EventSummary> response = restTemplate.exchange(url, HttpMethod.GET, serviceEntity(), EventSummary.class);
            return response.getBody();
        } catch (HttpClientErrorException.NotFound ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Event not found.");
        }
    }

    private HttpEntity<Void> serviceEntity() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Service-Token", serviceToken);
        return new HttpEntity<>(headers);
    }
}

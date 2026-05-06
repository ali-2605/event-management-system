package com.example.event.service.client;

import com.example.event.domain.NotificationType;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class NotificationClient {

    private final RestTemplate restTemplate;
    private final String baseUrl;
    private final String serviceToken;

    public NotificationClient(
            RestTemplate restTemplate,
            @Value("${services.notification.base-url}") String baseUrl,
            @Value("${security.service-token}") String serviceToken
    ) {
        this.restTemplate = restTemplate;
        this.baseUrl = baseUrl;
        this.serviceToken = serviceToken;
    }

    public void notifyAttendees(UUID eventId, List<UUID> attendeeIds, String message, NotificationType type) {
        if (attendeeIds == null || attendeeIds.isEmpty()) {
            return;
        }

        NotifyAttendeesRequest request = new NotifyAttendeesRequest(eventId, attendeeIds, type, message);

        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Service-Token", serviceToken);
        HttpEntity<NotifyAttendeesRequest> entity = new HttpEntity<>(request, headers);
        String url = baseUrl + "/internal/notifications/event";
        restTemplate.exchange(url, HttpMethod.POST, entity, Void.class);
    }
}

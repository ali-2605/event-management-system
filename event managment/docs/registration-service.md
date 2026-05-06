# Registration Service API

Base URL: /api/registrations

All endpoints require Authorization: Bearer <token>.

## Error Response Format

{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Error description",
  "path": "/api/registrations"
}

## Register For Event (Attendee)

POST /api/registrations

Request

{
  "eventId": "UUID"
}

Responses

200 OK
{
  "registrationId": "UUID",
  "eventId": "UUID",
  "attendeeId": "UUID",
  "status": "ACTIVE",
  "registeredAt": "2026-05-01T10:00:00Z",
  "canceledAt": null
}

409 Conflict (duplicate, canceled event, or capacity reached)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 409,
  "error": "Conflict",
  "message": "Event capacity has been reached.",
  "path": "/api/registrations"
}

## Cancel Registration (Attendee)

DELETE /api/registrations/{registrationId}

Responses

200 OK
{
  "registrationId": "UUID",
  "eventId": "UUID",
  "attendeeId": "UUID",
  "status": "CANCELED",
  "registeredAt": "2026-05-01T10:00:00Z",
  "canceledAt": "2026-05-01T12:00:00Z"
}

403 Forbidden (not owner or not attendee)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "You can only cancel your own registration.",
  "path": "/api/registrations/{registrationId}"
}

## Health

GET /health

Responses

200 OK
{
  "status": "ok"
}

## Get Registrations For Event

GET /api/registrations/event/{eventId}

Responses

200 OK
[
  {
    "registrationId": "UUID",
    "eventId": "UUID",
    "attendeeId": "UUID",
    "status": "ACTIVE",
    "registeredAt": "2026-05-01T10:00:00Z",
    "canceledAt": null
  }
]

## Get My Registrations (Attendee)

GET /api/registrations/me

Responses

200 OK
[
  {
    "registrationId": "UUID",
    "eventId": "UUID",
    "attendeeId": "UUID",
    "status": "ACTIVE",
    "registeredAt": "2026-05-01T10:00:00Z",
    "canceledAt": null
  }
]

## Internal Endpoints (Service Token Only)

These endpoints require header:

X-Service-Token: SECRET_KEY

GET /internal/registrations/event/{eventId}/attendees

Response

[
  "UUID",
  "UUID"
]

GET /internal/registrations/event/{eventId}/count

Response

12

POST /internal/registrations/event/{eventId}/cancel

Response

12

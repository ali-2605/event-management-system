# Notification Service API

Base URL: /api/notifications

All endpoints require Authorization: Bearer <token>.

## Error Response Format

{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Error description",
  "path": "/api/notifications"
}

## Get My Notifications (Attendee)

GET /api/notifications

Query Params

- seen=true|false
- from=ISO_DATE_TIME
- to=ISO_DATE_TIME
- eventId=UUID
- sort=createdAt,asc|desc

Responses

200 OK
[
  {
    "notificationId": "UUID",
    "attendeeId": "UUID",
    "eventId": "UUID",
    "message": "Event 'AI Workshop' has been updated. Please check the new details.",
    "type": "UPDATED",
    "read": false,
    "createdAt": "2026-05-01T10:00:00Z"
  }
]

## Toggle Notification Read (Attendee)

PATCH /api/notifications/{notificationId}

Responses

200 OK
{
  "notificationId": "UUID",
  "attendeeId": "UUID",
  "eventId": "UUID",
  "message": "Event 'AI Workshop' has been updated. Please check the new details.",
  "type": "UPDATED",
  "read": true,
  "createdAt": "2026-05-01T10:00:00Z"
}

403 Forbidden (not owner or not attendee)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "You can only modify your own notifications.",
  "path": "/api/notifications/{notificationId}"
}

## Health

GET /health

Responses

200 OK
{
  "status": "ok"
}

## Internal Endpoints (Service Token Only)

These endpoints require header:

X-Service-Token: SECRET_KEY

POST /internal/notifications/event

Request

{
  "eventId": "UUID",
  "attendeeIds": ["UUID", "UUID"],
  "type": "UPDATED",
  "message": "Event 'AI Workshop' has been updated. Please check the new details."
}

Response

2

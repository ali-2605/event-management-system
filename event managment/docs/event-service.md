# Event Service API

Base URL: /api/events

All endpoints require Authorization: Bearer <token>.

## Error Response Format

{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Error description",
  "path": "/api/events"
}

## Get All Events

GET /api/events

Query Params

- mine=true (organizer only, otherwise 403)
- status=ACTIVE|CANCELED
- from=ISO_DATE_TIME
- to=ISO_DATE_TIME
- sort=startsAt,asc|desc
- sort=endsAt,asc|desc
- sort=capacity,asc|desc
- sort=createdAt,asc|desc

Responses

200 OK
[
  {
    "eventId": "UUID",
    "title": "AI Workshop",
    "description": "Intro to AI",
    "location": "Room 101",
    "startsAt": "2026-05-01T10:00:00Z",
    "endsAt": "2026-05-01T12:00:00Z",
    "capacity": 50,
    "organizerId": "UUID",
    "status": "ACTIVE",
    "createdAt": "2026-05-01T09:00:00Z"
  }
]

403 Forbidden (mine=true for non-organizer)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Only organizers can filter by mine=true.",
  "path": "/api/events"
}

## Get Event By ID

GET /api/events/{eventId}

Responses

200 OK
{
  "eventId": "UUID",
  "title": "AI Workshop",
  "description": "Intro to AI",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50,
  "organizerId": "UUID",
  "status": "ACTIVE",
  "createdAt": "2026-05-01T09:00:00Z"
}

404 Not Found
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 404,
  "error": "Not Found",
  "message": "Event not found.",
  "path": "/api/events/{eventId}"
}

## Create Event (Organizer)

POST /api/events

Request

{
  "title": "AI Workshop",
  "description": "Intro to AI",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50
}

Responses

200 OK
{
  "eventId": "UUID",
  "title": "AI Workshop",
  "description": "Intro to AI",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50,
  "organizerId": "UUID",
  "status": "ACTIVE",
  "createdAt": "2026-05-01T09:00:00Z"
}

403 Forbidden (non-organizer)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Organizer role required.",
  "path": "/api/events"
}

## Update Event (Organizer)

PUT /api/events/{eventId}

Request

{
  "title": "AI Workshop",
  "description": "Updated description",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50
}

Responses

200 OK
{
  "eventId": "UUID",
  "title": "AI Workshop",
  "description": "Updated description",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50,
  "organizerId": "UUID",
  "status": "ACTIVE",
  "createdAt": "2026-05-01T09:00:00Z"
}

403 Forbidden (not organizer or not owner)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Only the organizer can update this event.",
  "path": "/api/events/{eventId}"
}

409 Conflict (capacity too low or canceled)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 409,
  "error": "Conflict",
  "message": "Capacity cannot be lower than active registrations.",
  "path": "/api/events/{eventId}"
}

## Cancel Event (Organizer)

DELETE /api/events/{eventId}

Responses

200 OK
{
  "eventId": "UUID",
  "title": "AI Workshop",
  "description": "Updated description",
  "location": "Room 101",
  "startsAt": "2026-05-01T10:00:00Z",
  "endsAt": "2026-05-01T12:00:00Z",
  "capacity": 50,
  "organizerId": "UUID",
  "status": "CANCELED",
  "createdAt": "2026-05-01T09:00:00Z"
}

403 Forbidden (not organizer or not owner)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Only the organizer can cancel this event.",
  "path": "/api/events/{eventId}"
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

GET /internal/events/{eventId}

Response

{
  "eventId": "UUID",
  "status": "ACTIVE",
  "capacity": 50
}

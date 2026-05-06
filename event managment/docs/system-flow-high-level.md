# Event Management System High-Level Flow

This document explains the end-to-end system flow from user registration to attendee notifications.

## 1. Services at a glance

- Auth Service
  - Owns user accounts and login
  - Issues JWT access tokens
- Event Service
  - Owns event lifecycle (create, update, cancel, list)
  - Coordinates outbound notification triggers
- Registration Service
  - Owns attendee registrations per event
  - Enforces registration rules
- Notification Service
  - Stores and serves attendee notifications
  - Marks notifications as read/unread
- PostgreSQL
  - Shared database engine
  - Each service manages its own tables

## 2. Roles and trust boundaries

- Public users call service APIs with Bearer JWT tokens.
- JWT is validated by services using the shared JWT secret.
- Internal service-to-service endpoints are protected with X-Service-Token.
- Cross-service references are ID-based (UUID), not JPA relations across services.

## 3. Core user journey (registration to notification)

### Step A: User account registration and login

1. Client calls Auth Service register endpoint.
2. Auth Service validates input, stores user account with role.
3. Auth Service returns a JWT token.
4. Client can also call login endpoint later to receive a new JWT token.

Outcome: Client now has role-based credentials for protected APIs.

### Step B: Organizer creates an event

1. Organizer calls Event Service create endpoint with Bearer token.
2. Event Service validates JWT and role ORGANIZER.
3. Event Service persists event data and returns event details.

Outcome: Event exists with ACTIVE status and organizer ownership.

### Step C: Attendee registers for an event

1. Attendee calls Registration Service create endpoint with eventId.
2. Registration Service validates JWT and role ATTENDEE.
3. Registration Service calls Event Service internal summary endpoint to verify event state and capacity.
4. If checks pass, Registration Service stores attendee registration.

Outcome: Registration is ACTIVE for the attendee and event.

### Step D: Organizer updates or cancels event

1. Organizer calls Event Service update or cancel endpoint.
2. Event Service validates ownership and business rules.
3. Event Service asks Registration Service for attendee IDs for that event.
4. Event Service sends notify request to Notification Service internal endpoint:
   - UPDATED message when event details change
   - CANCELED message when event is canceled
5. For cancel flow, Event Service also requests Registration Service to cancel active registrations.

Outcome: Affected attendees are identified, and system-wide consistency is maintained.

### Step E: Attendee receives and reads notifications

1. Notification Service stores one notification record per attendee ID.
2. Attendee calls Notification Service list endpoint with Bearer token.
3. Notification Service returns attendee-scoped notifications.
4. Attendee can toggle read status for a notification.

Outcome: Attendee sees event change announcements and can track read/unread state.

## 4. High-level sequence (text diagram)

1. Client -> Auth Service: register/login
2. Auth Service -> Client: JWT token
3. Organizer Client -> Event Service: create/update/cancel event (Bearer JWT)
4. Attendee Client -> Registration Service: register for event (Bearer JWT)
5. Registration Service -> Event Service (internal): validate event summary
6. Event Service -> Registration Service (internal): fetch attendee IDs / cancel registrations
7. Event Service -> Notification Service (internal): create attendee notifications
8. Attendee Client -> Notification Service: list/toggle notifications (Bearer JWT)

## 5. Data ownership by service

- Auth Service
  - Users, roles, credentials
- Event Service
  - Event metadata and lifecycle state
- Registration Service
  - Registration records and status transitions
- Notification Service
  - Notification messages and read state

Each service owns its write model and exposes APIs for other services when needed.

## 6. Error and validation behavior

- Services throw business and auth failures using HTTP status codes.
- Error payloads include message text for client debugging.
- Typical responses:
  - 400 for validation/input errors
  - 401 for missing or invalid authentication
  - 403 for role/permission failures
  - 404 for missing resources
  - 409 for business conflicts (for example capacity or canceled state)

## 7. Why this flow is useful

- Clear separation of responsibilities per service
- Explicit internal contracts between services
- Role-based API protection for external calls
- Event-driven notification behavior without tight coupling
- Easy to extend with more channels (email, SMS, push) through Notification Service

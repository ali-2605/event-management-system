# Backend Microservices Documentation

This document focuses on the backend architecture with an emphasis on the microservices design and how key concepts are implemented in this project.

## System Overview

### Components

- API Gateway (Spring Cloud Gateway)
- Service Discovery (Eureka Server)
- Auth Service
- Event Service
- Registration Service
- Notification Service
- PostgreSQL

### Ports (Docker defaults)

- Gateway: 8080
- Auth: 8081
- Event: 8082
- Registration: 8083
- Notification: 8084
- Eureka: 8761
- PostgreSQL: 5433

### Runtime Topology

- All services run on the same Docker Compose network (event-network).
- Each service registers with Eureka, and the gateway routes traffic based on path predicates.
- External clients call the gateway. Services expose internal endpoints for service-to-service calls.
- PostgreSQL is a shared database engine, but each service owns its tables and does not use cross-service JPA relations.

## Microservices and Cloud

### Service Responsibilities

- Auth Service: user accounts, password hashing, JWT issuance.
- Event Service: event lifecycle and organizer actions.
- Registration Service: attendee registrations and registration rules.
- Notification Service: attendee notifications and read state.

### Service Discovery and Routing

- Eureka provides service discovery. All services are configured with a Eureka defaultZone and prefer IP address.
- The gateway uses discovery-based URIs (lb://service-name) and routes:
  - /api/auth/** -> auth-service
  - /api/events/** -> event-service
  - /api/registrations/** -> registration-service
  - /api/notifications/** -> notification-service

### Inter-Service Communication

- Synchronous REST calls using RestTemplate.
- Internal endpoints are under /internal/** and require an X-Service-Token header.
- Examples:
  - Registration Service calls Event Service for event summary checks before registering.
  - Event Service calls Registration Service for attendee lists and active counts.
  - Event Service calls Notification Service to create notifications.

## Implementation (APIs)

### External API Surface (via Gateway)

- Auth: /api/auth/**
- Events: /api/events/**
- Registrations: /api/registrations/**
- Notifications: /api/notifications/**

### Internal APIs (service-to-service)

- Event Service: /internal/events/{eventId}
- Registration Service:
  - /internal/registrations/event/{eventId}/attendees
  - /internal/registrations/event/{eventId}/count
  - /internal/registrations/event/{eventId}/cancel
- Notification Service:
  - /internal/notifications/event

### Detailed Endpoint Docs

See the service-specific API docs:

- docs/auth-service.md
- docs/event-service.md
- docs/registration-service.md
- docs/notification-service.md

## Design Pattern (Publisher/Subscriber)

The Notification Service implements an in-process publisher/subscriber pattern to decouple notification creation from downstream actions:

- NotificationService builds a NotificationEvent and calls NotificationPublisher.publish(...).
- NotificationPublisher maintains a list of NotificationSubscriber implementations and invokes each subscriber with the event.
- NotificationPersistenceSubscriber subscribes to NotificationEvent and persists the notifications to the database.

This design allows new subscribers (for example, email or SMS delivery) to be added without changing the publisher or core service logic.

## Aspect Oriented Programming (AOP)

AOP is used for observability in each service:

- AuthObservabilityAspect
- EventObservabilityAspect
- RegistrationObservabilityAspect
- NotificationObservabilityAspect

Each aspect wraps service-layer methods (execution(public * ..service..*(..))) and logs:

- Start with method signature and args
- Success with duration
- Failure with duration and exception type

This provides consistent, centralized logging without scattering logging code across services.

## Object Constraint Language (OCL)

Formal OCL is not used in this codebase. Instead, constraints and invariants are implemented with:

- Jakarta Bean Validation annotations on request DTOs (for example, @NotNull, @NotBlank, @Email, @Positive).
- Database-level unique constraints via JPA annotations (for example, unique email and unique attendee-event registrations).
- Service-layer invariants, such as:
  - Event capacity cannot be reduced below active registrations.
  - Canceled events cannot be updated or registered against.
  - Attendees can only cancel their own registrations.

These checks serve the same purpose as OCL constraints, enforced at API boundaries and domain operations.

## Docker

Docker is the primary deployment and local runtime mechanism:

- docker compose defines all backend containers and a shared network.
- PostgreSQL runs as its own container with a persistent volume.
- Services are built from their Dockerfiles and configured via environment variables.
- Health checks are used to ensure the database is ready before services start.

## Clean Code Practices

The codebase follows a clean, layered structure across services:

- web package for controllers and API DTOs
- service package for business logic and validation
- data package for repositories
- domain package for entities and enums
- config and security packages for infrastructure concerns

Additional clean code practices:

- Thin controllers that delegate to services.
- DTOs with explicit validation rules.
- Centralized exception handling with consistent error payloads.
- Consistent naming and role-based authorization checks.

## Security Architecture

- Auth Service issues JWTs with userId and role.
- All external API calls require Authorization: Bearer <token>.
- Internal endpoints require X-Service-Token and a SERVICE role enforced by security filters.
- Services are stateless (JWT-based) and rely on the database for persistence.

## Data Ownership and Persistence

- A shared PostgreSQL engine is used for simplicity in local and Docker deployments.
- Each service owns its tables and writes only to its own data.
- Cross-service references are ID-based (UUIDs), not JPA relationships.

## Summary

This backend is a multi-service Spring Boot system with service discovery, gateway routing, explicit internal APIs, centralized validation, AOP-based observability, and a publisher/subscriber design inside the notification domain. The architecture prioritizes separation of concerns, clear ownership boundaries, and operational simplicity through Docker.

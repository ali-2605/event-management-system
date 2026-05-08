# Event Management System

Spring Boot microservices for event management, split into four services backed by a shared PostgreSQL database, plus a Spring Cloud Gateway and Eureka server.

## Services and ports

- Auth service: 8081
- Event service: 8082
- Registration service: 8083
- Notification service: 8084
- API Gateway: 8080
- Eureka Server: 8761
- PostgreSQL: 5433

## Run with Docker (dev)

From [event managment](event%20managment):

```bash
./start.sh
```

Useful commands:

```bash
./logs.sh
./stop.sh
```

`docker compose up --build` starts the gateway, Eureka server, database, and the four services.

Clients should use the gateway at `http://localhost:8080`.

## Environment values

Copy `.env.example` to `.env` if you want to customize ports, credentials, or service URLs.

Default values:

```text
AUTH_PORT=8081
EVENT_PORT=8082
REGISTRATION_PORT=8083
NOTIFICATION_PORT=8084
DB_PORT=5433

POSTGRES_DB=event_management
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

JWT_SECRET=SuperSecretSuperSecretSuperSecret123456
JWT_EXPIRATION_DAYS=7
SERVICE_TOKEN=SuperDuperServiceTokenKey
```

`JWT_SECRET` must be at least 32 bytes for HS256.

## Health endpoints

```text
GET http://localhost:8080/health
GET http://localhost:8761/health
```

The four backend services are now intended to be reached through the gateway in Docker.

## Authentication

- `POST /api/auth/register` and `POST /api/auth/login` return `{ "token": "..." }`.
- Gateway routes:
	- `http://localhost:8080/api/auth/**`
	- `http://localhost:8080/api/events/**`
	- `http://localhost:8080/api/registrations/**`
	- `http://localhost:8080/api/notifications/**`
- Pass the token as `Authorization: Bearer <token>` to protected routes.
- Internal service-to-service calls use `X-Service-Token` for `/internal/**` endpoints.

## API basics

- Events: `GET /api/events?mine=&status=&from=&to=&sort=field,asc|desc`
- Notifications: `GET /api/notifications?seen=&from=&to=&eventId=&sort=createdAt,asc|desc`
- Registrations: `POST /api/registrations` with `{ "eventId": "..." }`

Error responses include `message` and validation details for easier debugging.

## Tests

From `event managment`:

```bash
./gradlew testAll
```

Run a single service test suite:

```bash
./gradlew :auth-service:test
./gradlew :event-service:test
./gradlew :registration-service:test
./gradlew :notification-service:test
```

Run gateway and Eureka builds:

```bash
./gradlew :gateway:bootJar
./gradlew :eureka-server:bootJar
```

## Integration Tests

Integration tests verify cross-service communication and flows. They require all services to be running.

### Start services and run integration tests:

```bash
cd event\ managment

# Terminal 1: Start services
docker compose up --build

# Terminal 2: Run integration tests
./gradlew :integration-tests:test
```

Integration tests verify:
- User authentication flows (register, login)
- Service-to-service communication
- API error handling and validation
- Health checks across all services

See `integration-tests/src/test/java/com/example/integration/` for test implementations.

## Integration Tests

Integration tests verify cross-service communication and flows. They require all services to be running.

### Start services and run integration tests:

```bash
cd event\ managment

# Terminal 1: Start services
docker compose up --build

# Terminal 2: Run integration tests
./gradlew :integration-tests:test
```

Integration tests verify:
- User authentication flows (register, login)
- Service-to-service communication
- API error handling and validation
- Health checks across all services

See `integration-tests/src/test/java/com/example/integration/` for test implementations.

## Integration Tests

Integration tests verify cross-service communication and flows. They require all services to be running.

### Start services and run integration tests:

```bash
cd event\ managment

# Terminal 1: Start services
docker compose up --build

# Terminal 2: Run integration tests
./gradlew :integration-tests:test
```

Integration tests verify:
- User authentication flows (register, login)
- Service-to-service communication
- API error handling and validation
- Health checks across all services

See `integration-tests/src/test/java/com/example/integration/` for test implementations.

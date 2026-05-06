# Event Management System

Spring Boot microservices for event management, split into four services backed by a shared PostgreSQL database.

## Services and ports

- Auth service: 8081
- Event service: 8082
- Registration service: 8083
- Notification service: 8084
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

`start.sh` uses `compose.yaml` + `compose.dev.yaml` to run each service with `bootRun` and live reload.

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
GET http://localhost:8081/health
GET http://localhost:8082/health
GET http://localhost:8083/health
GET http://localhost:8084/health
```

Note: current security rules may return 401/403 for health checks unless you permit `/health` in each service.

## Authentication

- `POST /api/auth/register` and `POST /api/auth/login` return `{ "token": "..." }`.
- Pass the token as `Authorization: Bearer <token>` to protected routes.
- Internal service-to-service calls use `X-Service-Token` for `/internal/**` endpoints.

## API basics

- Events: `GET /api/events?mine=&status=&from=&to=&sort=field,asc|desc`
- Notifications: `GET /api/notifications?seen=&from=&to=&eventId=&sort=createdAt,asc|desc`
- Registrations: `POST /api/registrations` with `{ "eventId": "..." }`

Error responses include `message` and validation details for easier debugging.

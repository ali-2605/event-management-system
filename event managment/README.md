# Event Management System Starter

This folder contains the Spring Boot starter project for the Event Management System.

## What is included

- Spring Boot starter wired to PostgreSQL
- Dockerfile for the application container
- `compose.yaml` for the application and PostgreSQL containers
- Bash scripts to start, stop, and inspect logs
- Starter layered architecture for Auth, Event, Registration, and Notification

## Architecture

The codebase is scaffolded with a layered structure:

- `presentation/`: controllers and request DTOs
- `application/`: service layer and business flow entry points
- `data/`: JPA repositories
- `domain/`: entities and enums
- `config/`: shared framework configuration

## Package layout

```text
src/main/java/com/example/demo
├── application
├── common
├── config
├── data
├── domain
└── presentation
```

The current controllers intentionally return `501 Not Implemented` for unfinished business endpoints. This lets the application boot cleanly while showing your team where to continue implementation.

## Run with Docker

From this folder, run:

```bash
./start.sh
```

Useful commands:

```bash
./logs.sh
./stop.sh
```

## Environment values

Copy `.env.example` to `.env` if you want to customize ports or database credentials.

Default values:

```text
APP_PORT=8080
DB_PORT=5433
POSTGRES_DB=event_management
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

## Health endpoint

After startup, verify the app is running:

```text
GET http://localhost:8080/api/health
```

## Local Gradle run

If you want to run the app without Docker, make sure PostgreSQL is running locally and then use:

```bash
./gradlew bootRun
```

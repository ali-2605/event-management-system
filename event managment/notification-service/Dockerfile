# syntax=docker/dockerfile:1.7
# Multi-stage build for Notification Service
FROM gradle:9.4-jdk21 AS builder

WORKDIR /build
ENV GRADLE_USER_HOME=/home/gradle/.gradle

# Copy root project files
COPY settings.gradle build.gradle ./
COPY gradle ./gradle
COPY gradlew ./

# Copy only notification-service source code
COPY notification-service ./notification-service

# Ensure other project directories exist so the root `settings.gradle` can configure them
RUN mkdir -p /build/auth-service /build/event-service /build/registration-service /build/gateway /build/eureka-server /build/integration-tests

# Build only the notification-service using a shared Gradle cache
RUN --mount=type=cache,id=gradle-cache,target=/home/gradle/.gradle,sharing=locked gradle :notification-service:bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /build/notification-service/build/libs/*.jar app.jar

# Expose the port
EXPOSE 8084

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]

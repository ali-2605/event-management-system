# syntax=docker/dockerfile:1.7
# Multi-stage build for Auth Service
FROM gradle:9.4-jdk21 AS builder

WORKDIR /build
ENV GRADLE_USER_HOME=/home/gradle/.gradle

# Copy root project files
COPY settings.gradle build.gradle ./
COPY gradle ./gradle
COPY gradlew ./

# Copy only auth-service source code
COPY auth-service ./auth-service

# Ensure other project directories exist so the root `settings.gradle` can configure them
RUN mkdir -p /build/event-service /build/registration-service /build/notification-service /build/gateway /build/eureka-server /build/integration-tests

# Build only the auth-service using a shared Gradle cache
RUN --mount=type=cache,id=gradle-cache,target=/home/gradle/.gradle,sharing=locked gradle :auth-service:bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /build/auth-service/build/libs/*.jar app.jar

# Expose the port
EXPOSE 8081

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]

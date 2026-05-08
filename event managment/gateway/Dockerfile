# syntax=docker/dockerfile:1.7
# Multi-stage build for API Gateway
FROM gradle:9.4-jdk21 AS builder

WORKDIR /build
ENV GRADLE_USER_HOME=/home/gradle/.gradle

COPY settings.gradle build.gradle ./
COPY gradle ./gradle
COPY gradlew ./

COPY gateway ./gateway

RUN mkdir -p /build/auth-service /build/event-service /build/registration-service /build/notification-service /build/eureka-server /build/integration-tests

RUN --mount=type=cache,id=gradle-cache,target=/home/gradle/.gradle,sharing=locked gradle :gateway:bootJar --no-daemon

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /build/gateway/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

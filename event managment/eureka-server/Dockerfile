# syntax=docker/dockerfile:1.7
# Multi-stage build for Eureka Server
FROM gradle:9.4-jdk21 AS builder

WORKDIR /build
ENV GRADLE_USER_HOME=/home/gradle/.gradle

COPY settings.gradle build.gradle ./
COPY gradle ./gradle
COPY gradlew ./

COPY eureka-server ./eureka-server

RUN mkdir -p /build/auth-service /build/event-service /build/registration-service /build/notification-service /build/gateway /build/integration-tests

RUN --mount=type=cache,id=gradle-cache,target=/home/gradle/.gradle,sharing=locked gradle :eureka-server:bootJar --no-daemon

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /build/eureka-server/build/libs/*.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]

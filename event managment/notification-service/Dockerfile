FROM eclipse-temurin:21-jdk AS build

WORKDIR /workspace
ENV GRADLE_USER_HOME=/root/.gradle

COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
COPY notification-service ./notification-service

# Gradle configures the full multi-project build, so the missing modules still
# need placeholder directories even when this image only builds one service.
RUN set -eux; \
    chmod +x gradlew; \
    for module in auth-service event-service registration-service gateway eureka-server integration-tests; do \
        mkdir -p "$module"; \
    done

RUN ./gradlew :notification-service:bootJar --no-daemon && \
    cp /workspace/notification-service/build/libs/*.jar /workspace/app.jar

FROM eclipse-temurin:21-jre AS runtime

RUN useradd --system --create-home appuser
WORKDIR /app

COPY --from=build --chown=appuser:appuser /workspace/app.jar /app/app.jar

USER appuser

EXPOSE 8084

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

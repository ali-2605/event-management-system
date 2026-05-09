FROM eclipse-temurin:21-jdk AS build

WORKDIR /workspace
ENV GRADLE_USER_HOME=/root/.gradle

COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
COPY eureka-server ./eureka-server

# Gradle configures the full multi-project build, so the missing modules still
# need placeholder directories even when this image only builds one service.
RUN set -eux; \
    chmod +x gradlew; \
    for module in auth-service event-service registration-service notification-service gateway integration-tests; do \
        mkdir -p "$module"; \
    done

RUN ./gradlew :eureka-server:bootJar --no-daemon && \
    cp /workspace/eureka-server/build/libs/*.jar /workspace/app.jar

FROM eclipse-temurin:21-jre AS runtime

RUN useradd --system --create-home appuser
WORKDIR /app

COPY --from=build --chown=appuser:appuser /workspace/app.jar /app/app.jar

USER appuser

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

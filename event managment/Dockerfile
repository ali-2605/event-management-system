FROM gradle:9.4.1-jdk21 AS builder

WORKDIR /workspace

COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN gradle dependencies --no-daemon

COPY src src

RUN gradle bootJar --no-daemon

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /workspace/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

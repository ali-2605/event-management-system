FROM gradle:9.4.1-jdk21 AS build

WORKDIR /workspace

COPY . .
RUN gradle :notification-service:bootJar --no-daemon
RUN set -eux; jar_file=$(find notification-service/build/libs -maxdepth 1 -name '*.jar' ! -name '*-plain.jar' | head -n 1); cp "$jar_file" /tmp/app.jar

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /tmp/app.jar app.jar

EXPOSE 8084

ENTRYPOINT ["java", "-jar", "app.jar"]

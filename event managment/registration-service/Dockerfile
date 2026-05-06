FROM eclipse-temurin:21-jre

WORKDIR /app

COPY registration-service/build/libs/*.jar app.jar

EXPOSE 8083

ENTRYPOINT ["java", "-jar", "app.jar"]

FROM openjdk:8-jdk-alpine AS builder
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]



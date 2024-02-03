FROM openjdk:8-jdk-alpine AS builder
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]

FROM nginx
EXPOSE 8082
COPY --from=builder /app.jar /usr/share/nginx/html

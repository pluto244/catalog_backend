# Build stage
FROM gradle:8.10.0-jdk17-alpine AS build
WORKDIR /home/gradle/src
COPY . .
RUN gradle build --no-daemon

# Package stage
FROM eclipse-temurin:17-jre-alpine
COPY --from=build /home/gradle/src/build/libs/catalog-1.jar catalog-1.jar
ENTRYPOINT ["java","-jar","catalog-1.jar"]

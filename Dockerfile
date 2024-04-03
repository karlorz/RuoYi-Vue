# Use an official Maven image as the base image
FROM maven:3.9-ibmjava-8 AS build
# FROM eclipse-temurin:8-jdk-alpine AS build
WORKDIR /app

COPY pom.xml .
COPY ruoyi-admin ruoyi-admin
COPY ruoyi-common ruoyi-common
COPY ruoyi-framework ruoyi-framework
COPY ruoyi-generator ruoyi-generator
COPY ruoyi-quartz ruoyi-quartz
COPY ruoyi-system ruoyi-system

# Build the application using Maven
RUN mvn clean package -Dmaven.test.skip=true

FROM eclipse-temurin:8-jre
WORKDIR /app

COPY --from=build /app/ruoyi-admin/target/ruoyi-admin.jar .

ENTRYPOINT ["java","-jar","ruoyi-admin.jar"]
# === Stage 1: Build the application ===
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Package the application (skip tests if needed)
RUN mvn clean package -DskipTests

# === Stage 2: Run the application ===
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8081

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

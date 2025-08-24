# ---- Stage 1: Build the application ----
FROM maven:3.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the project and skip tests for speed (remove -DskipTests to run them)
RUN mvn clean package -DskipTests

# ---- Stage 2: Run the application ----
FROM eclipse-temurin:17-jre-noble

# Copy the built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Set the entry point
ENTRYPOINT ["java", "-jar", "/app.jar"]

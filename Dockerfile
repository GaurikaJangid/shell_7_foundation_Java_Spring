# Use the official Maven image as the base image
FROM maven:3.6.3-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /home /app

# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# Use the official OpenJDK image as the base image for the runtime
FROM openjdk:11-jdk-slim AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build image to the runtime image
COPY --from=build /app/target/your-application-name.jar .

# Specify the command to run the application
CMD ["java", "-jar", "your-application-name.jar"]

# Use OpenJDK 17 Alpine for smaller image size
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Install Maven
RUN apk add --no-cache maven

# Copy pom.xml
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Create runtime image
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy the built JAR file
COPY --from=0 /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Start the application
CMD ["java", "-jar", "app.jar"]

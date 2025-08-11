# Basic Java Web Application

A simple Java web application built with Spring Boot without database connectivity.

## Features

- Lightweight web server using Spring Boot
- JSON API endpoints
- No database dependencies
- Docker containerized
- RESTful API design

## Dependencies

- Java 17+
- Spring Boot 3.2.0
- Spring Boot Web Starter
- Maven for build management

## Endpoints

### GET /

Returns basic service information

```json
{
  "message": "Java API is running!",
  "status": "ok",
  "timestamp": 1234567890,
  "service": "java-basic"
}
```

### GET /health

Health check endpoint

```json
{
  "status": "healthy",
  "service": "java",
  "uptime": 1234567890
}
```

### GET /info

Returns API information and available endpoints

```json
{
  "service": "Java Basic API",
  "version": "1.0.0",
  "description": "A simple Java web application without database",
  "endpoints": [
    "/",
    "/health",
    "/info",
    "/echo",
    "/math/add",
    "/math/multiply",
    "/data"
  ],
  "modules": "Spring Boot Web only"
}
```

### GET /echo?message=Hello

Echo endpoint that returns the provided message

```json
{
  "echo": "Hello",
  "timestamp": 1234567890
}
```

### GET /math/add?a=5&b=3

Simple addition calculator

```json
{
  "operation": "addition",
  "a": 5,
  "b": 3,
  "result": 8
}
```

### GET /math/multiply?a=4&b=6

Simple multiplication calculator

```json
{
  "operation": "multiplication",
  "a": 4,
  "b": 6,
  "result": 24
}
```

### POST /data

Accepts JSON data and returns it with a timestamp

```json
{
  "received": { "key": "value" },
  "processed": 1234567890,
  "message": "Data received successfully"
}
```

## Running the Application

### Using Docker Compose

The Java application is configured to work with the main nginx reverse proxy:

```bash
docker-compose up java
```

### Local Development

```bash
# Build the application
mvn clean package

# Run the application
java -jar target/java-api-0.1.0.jar
```

The application will be available at `http://localhost:8080` or `http://localhost/java/` through the nginx reverse proxy.

## Technical Details

- **Web Server**: Embedded Tomcat (Spring Boot)
- **Framework**: Spring Boot 3.2.0
- **JSON Processing**: Jackson (included with Spring Boot)
- **Error Handling**: Spring Boot default error handling
- **No Database**: Zero database dependencies

## Advantages

- **Performance**: Spring Boot with embedded Tomcat
- **Modern**: Latest Spring Boot version with Java 17
- **Containerized**: Ready for Docker deployment
- **Simple**: Easy to understand and extend
- **RESTful**: Clean REST API design

# Basic PHP Web Application

A simple PHP web application built with Slim Framework using PHP-FPM.

## Features

- PHP-FPM for processing PHP requests
- JSON API endpoints
- No database dependencies
- Docker containerized
- Works with main nginx reverse proxy

## Dependencies

- PHP 8.2+ with FPM
- Slim Framework 4.11
- PSR-7 HTTP Message Interface
- PHP-DI Container

## Endpoints

### GET /

Returns basic service information

```json
{
  "message": "PHP API is running!",
  "status": "ok",
  "timestamp": 1234567890,
  "service": "php-basic"
}
```

### GET /health

Health check endpoint

```json
{
  "status": "healthy",
  "service": "php",
  "uptime": 1234567890
}
```

### GET /info

Returns API information and available endpoints

```json
{
  "service": "PHP Basic API",
  "version": "1.0.0",
  "description": "A simple PHP web application without database",
  "endpoints": [
    "/",
    "/health",
    "/info",
    "/echo",
    "/math/add",
    "/math/multiply",
    "/data"
  ],
  "modules": "Slim Framework only"
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

The PHP application is configured to work with the main nginx reverse proxy:

```bash
docker-compose up php
```

### Local Development

```bash
# Install dependencies
composer install

# Run with PHP built-in server
php -S localhost:8000 index.php
```

The application will be available at `http://localhost/php/` through the nginx reverse proxy.

## Technical Details

- **PHP Processor**: PHP-FPM on port 9000
- **Web Server**: Main nginx reverse proxy handles HTTP requests
- **Framework**: Slim Framework 4.11
- **JSON Processing**: Built-in PHP JSON functions
- **Error Handling**: Slim error middleware enabled
- **No Database**: Zero database dependencies

## Architecture

- **Nginx Reverse Proxy**: Handles all HTTP requests on port 80
- **PHP-FPM Container**: Processes PHP requests on port 9000
- **FastCGI Communication**: Nginx communicates with PHP-FPM via FastCGI
- **Clean Separation**: Web server and PHP processor are separate services

## Advantages

- **Performance**: PHP-FPM is optimized for PHP processing
- **Scalability**: Can easily scale PHP-FPM instances
- **Modern**: Industry standard PHP architecture
- **Containerized**: Ready for Docker deployment
- **Simple**: Easy to understand and extend

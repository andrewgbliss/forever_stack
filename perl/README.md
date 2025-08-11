# Basic Perl Web Application (Core Only)

A simple Perl web application built using only core Perl modules - no external dependencies required.

## Features

- Pure core Perl implementation
- Built-in HTTP server using sockets
- JSON API endpoints
- No external dependencies
- Docker containerized
- Minimal footprint

## Core Modules Used

- `strict` - Enforce strict syntax
- `warnings` - Enable warnings
- `Socket` - Socket programming (core module)
- `IO::Handle` - IO operations (core module)
- `JSON::PP` - JSON processing (core module, included with Perl 5.14+)

## Endpoints

### GET /

Returns basic service information

```json
{
  "message": "Perl API is running!",
  "status": "ok",
  "timestamp": 1234567890,
  "service": "perl-basic-core"
}
```

### GET /health

Health check endpoint

```json
{
  "status": "healthy",
  "service": "perl",
  "uptime": 1234567890
}
```

### GET /info

Returns API information and available endpoints

```json
{
  "service": "Perl Basic API (Core Only)",
  "version": "1.0.0",
  "description": "A simple Perl web application using only core modules",
  "endpoints": [
    "/",
    "/health",
    "/info",
    "/echo",
    "/math/add",
    "/math/multiply",
    "/data"
  ],
  "modules": "Core Perl only - no external dependencies"
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

Accepts data and returns it with a timestamp

```json
{
  "received": { "received": "Data received", "raw_body": "..." },
  "processed": 1234567890,
  "message": "Data received successfully"
}
```

## Running the Application

### Using Docker

```bash
docker build -t perl-basic-core .
docker run -p 5000:5000 perl-basic-core
```

### Local Development

```bash
# Run the application directly (no dependencies to install!)
perl app.pl
```

The application will be available at `http://localhost:5000`

## Technical Details

- **HTTP Server**: Custom implementation using core Perl socket programming
- **JSON Processing**: Uses `JSON::PP` (Pure Perl JSON, included with Perl 5.14+)
- **Request Parsing**: Manual HTTP request parsing
- **Response Generation**: Manual HTTP response generation
- **No Dependencies**: Zero external CPAN modules required

## Advantages

- **Zero Dependencies**: No need to install any external modules
- **Small Footprint**: Minimal resource usage
- **Portable**: Works on any system with Perl 5.14+
- **Educational**: Demonstrates core Perl networking capabilities
- **Fast Startup**: No module loading overhead

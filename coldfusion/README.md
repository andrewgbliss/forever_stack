# ColdFusion Backend (Lucee)

A simple ColdFusion web application using Lucee that provides REST API endpoints without database dependencies.

## Features

- RESTful API endpoints
- JSON request/response handling
- Health check endpoint
- Mathematical operations
- Echo functionality
- Data processing

## API Endpoints

- `GET /` - Root endpoint with service status
- `GET /health` - Health check
- `GET /info` - Service information
- `GET /echo?message=Hello` - Echo endpoint
- `GET /math/add?a=5&b=3` - Addition operation
- `GET /math/multiply?a=4&b=6` - Multiplication operation
- `POST /data` - Process JSON data

## Running with Docker

```bash
# Build and run the container
docker build -t coldfusion-backend .
docker run -p 8500:8500 coldfusion-backend
```

## Running with Docker Compose

The ColdFusion backend is included in the main docker-compose.yml file and will run on port 8500.

```bash
docker-compose up coldfusion
```

## Local Development

To run locally, you'll need Lucee or Adobe ColdFusion installed and configured to run on port 8500.

## Example Usage

```bash
# Health check
curl http://localhost:8500/health

# Echo endpoint
curl "http://localhost:8500/echo?message=Hello%20World"

# Math operations
curl "http://localhost:8500/math/add?a=10&b=5"
curl "http://localhost:8500/math/multiply?a=4&b=7"

# POST data
curl -X POST http://localhost:8500/data \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "age": 30}'
```

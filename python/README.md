# Python FastAPI Backend

A simple Python web application built with FastAPI and Uvicorn.

## Features

- FastAPI framework for high-performance API development
- Automatic API documentation with Swagger UI
- Async/await support for better performance
- Type hints and Pydantic models for data validation
- Health check and monitoring endpoints

## Endpoints

- `GET /` - Root endpoint with service status
- `GET /health` - Health check endpoint
- `GET /info` - Service information and available endpoints
- `GET /echo?message=text` - Echo endpoint that returns the provided message
- `GET /math/add?a=1&b=2` - Add two numbers
- `GET /math/multiply?a=2&b=3` - Multiply two numbers
- `POST /data` - Process posted JSON data

## API Documentation

When running, visit `/docs` for interactive API documentation (Swagger UI) or `/redoc` for ReDoc documentation.

## Local Development

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Run the application:
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

3. Access the API at `http://localhost:8000`

## Docker

The application is containerized and can be run with Docker Compose as part of the forever_stack project.

## Dependencies

- FastAPI 0.104.1 - Modern web framework
- Uvicorn 0.24.0 - ASGI server
- Pydantic 2.5.0 - Data validation

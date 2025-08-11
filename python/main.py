from fastapi import FastAPI, Query
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import Optional, Dict, Any
import time
from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    print("Python FastAPI backend starting up...")
    yield
    # Shutdown
    print("Python FastAPI backend shutting down...")

app = FastAPI(
    title="Python FastAPI Backend",
    description="A simple Python web application without database",
    version="1.0.0",
    lifespan=lifespan
)

class DataRequest(BaseModel):
    data: Dict[str, Any]

@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Python API is running!",
        "status": "ok",
        "timestamp": int(time.time()),
        "service": "python-fastapi"
    }

@app.get("/health")
async def health():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "service": "python",
        "uptime": int(time.time())
    }

@app.get("/info")
async def info():
    """Service information endpoint"""
    return {
        "service": "Python FastAPI API",
        "version": "1.0.0",
        "description": "A simple Python web application without database",
        "endpoints": ["/", "/health", "/info", "/echo", "/math/add", "/math/multiply", "/data"],
        "modules": "FastAPI and Uvicorn only"
    }

@app.get("/echo")
async def echo(message: Optional[str] = Query(default="Hello World!")):
    """Echo endpoint that returns the provided message"""
    return {
        "echo": message,
        "timestamp": int(time.time())
    }

@app.get("/math/add")
async def add(a: int = Query(default=0), b: int = Query(default=0)):
    """Add two numbers"""
    return {
        "operation": "addition",
        "a": a,
        "b": b,
        "result": a + b
    }

@app.get("/math/multiply")
async def multiply(a: int = Query(default=1), b: int = Query(default=1)):
    """Multiply two numbers"""
    return {
        "operation": "multiplication",
        "a": a,
        "b": b,
        "result": a * b
    }

@app.post("/data")
async def process_data(data: DataRequest):
    """Process posted data"""
    return {
        "received": data.data,
        "processed": int(time.time()),
        "message": "Data received successfully"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

# Forever Stack Setup Guide

This Docker Compose setup includes a complete stack with multiple backend services and a frontend, all orchestrated through Nginx.

## Services Overview

- **Nginx** (Port 80): Reverse proxy that routes traffic to all services
- **PostgreSQL** (Port 5432): Database for all services
- **NextJS** (Port 3000): Main frontend application with Drizzle ORM
- **Perl** (Port 5000): Perl backend service
- **PHP** (Port 8000): PHP backend service  
- **Java** (Port 8080): Java backend service
- **Go** (Port 8081): Go backend service
- **Ruby** (Port 3001): Ruby backend service

## Quick Start

1. **Copy environment file:**
   ```bash
   cp .sample.env .env
   ```

2. **Edit the .env file:**
   - Replace `{domain name or ip}` in `DATABASE_URL` with your actual domain or IP
   - For local development, use `localhost`

3. **Start the stack:**
   ```bash
   docker-compose up -d
   ```

4. **Access the services:**
   - Main application: http://localhost
   - Perl API: http://localhost/perl/
   - PHP API: http://localhost/php/
   - Java API: http://localhost/java/
   - Go API: http://localhost/go/
   - Ruby API: http://localhost/ruby/
   - Health check: http://localhost/health

## Service Directories

You'll need to create the following directory structure with Dockerfiles for each service:

```
.
├── docker-compose.yml
├── .env
├── .sample.env
├── nginx/
│   └── nginx.conf
├── nextjs/
│   └── Dockerfile
├── perl/
│   └── Dockerfile
├── php/
│   └── Dockerfile
├── java/
│   └── Dockerfile
├── go/
│   └── Dockerfile
└── ruby/
    └── Dockerfile
```

## Environment Variables

- `DATABASE_URL`: PostgreSQL connection string
- `POSTGRES_PASSWORD`: Database password
- `POSTGRES_USER`: Database username
- `POSTGRES_DB`: Database name
- `NODE_ENV`: Node.js environment

## Network Architecture

All services are connected through a custom Docker network (`forever_stack_network`) and can communicate with each other using their service names as hostnames.

## Next Steps

1. Create the individual service directories and Dockerfiles
2. Implement your application logic in each service
3. Set up Drizzle ORM migrations in the NextJS service
4. Configure SSL certificates for production use

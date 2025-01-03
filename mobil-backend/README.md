# Mobil Backend

Mobil Backend is a Go-based backend application built with Fiber for managing user registration and authentication. It connects to a MongoDB database to store user information securely.

## Prerequisites

- Docker installed on your machine.
- Go installed if you want to run the application locally without Docker.

## Dockerization

### Build the Docker Image

To build the Docker image for the application, navigate to the project root directory and run:

```sh
docker build -t mobil-backend .
docker run -p 8080:8080 mobil-backend 
```

### Register a New User

```
curl -X POST http://localhost:8080/api/register \
  -H "Content-Type: application/json" \
  -d '{
        "email": "user@example.com",
        "password": "password123"
      }'
```

### Login with curl
```
curl -X POST http://localhost:8080/api/login \
  -H "Content-Type: application/json" \
  -d '{
        "email": "user@example.com",
        "password": "password123"
      }'
```

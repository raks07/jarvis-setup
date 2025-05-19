# API Documentation for Document Management and RAG-based Q&A Application

This document provides information on how to access and use the API documentation for both backend services in the application.

## Overview

The application consists of two backend services:

1. **jarvis-backend**: NestJS backend for user authentication and document management
2. **jarvis-datastore**: FastAPI backend for document ingestion and RAG-based Q&A

Both services provide interactive API documentation using Swagger UI and other OpenAPI tools.

## jarvis-backend API Documentation (NestJS)

### Access Points

- **Swagger UI**: `http://localhost:3000/api/docs`
  - Interactive API documentation with testing capabilities

### Authentication

1. Most endpoints require JWT authentication
2. Use the `/auth/login` endpoint to obtain a JWT token
3. Click the "Authorize" button in Swagger UI and enter your JWT token
4. Token format: `Bearer your_jwt_token`

### Available Endpoints

#### Authentication Endpoints

- **POST /auth/login**: Authenticate and get JWT token
- **POST /auth/register**: Register new user
- **POST /auth/validate-token**: Validate and refresh JWT token

#### User Management Endpoints

- **GET /users**: Get all users (admin only)
- **POST /users**: Create a new user (admin only)
- **GET /users/{id}**: Get a specific user
- **PATCH /users/{id}**: Update a user (admin only)
- **DELETE /users/{id}**: Delete a user (admin only)
- **GET /users/role/{role}**: Get users by role (admin only)

#### Document Management Endpoints

- **GET /documents**: Get all documents
- **POST /documents**: Upload a new document
- **GET /documents/{id}**: Get a specific document
- **PATCH /documents/{id}**: Update document metadata
- **DELETE /documents/{id}**: Delete a document
- **GET /documents/{id}/content**: Download document content

#### Ingestion Management Endpoints

- **GET /ingestion**: Get all ingestions
- **POST /ingestion**: Trigger document ingestion
- **GET /ingestion/{id}**: Get a specific ingestion
- **DELETE /ingestion/{id}**: Cancel an ingestion
- **GET /ingestion/document/{documentId}**: Get ingestions by document ID
- **POST /ingestion/webhook/status**: Update ingestion status (webhook)

## jarvis-datastore API Documentation (FastAPI)

### Access Points

- **Swagger UI**: `http://localhost:8000/api/docs`
  - Interactive API documentation with testing capabilities
- **ReDoc**: `http://localhost:8000/api/redoc`
  - Alternative documentation view, more readable for complex schemas

### Available Endpoints

#### Ingestion Endpoints

- **POST /api/ingestion/**: Ingest a document and generate embeddings
- **GET /api/ingestion/{document_id}**: Get ingestion status for a document
- **DELETE /api/ingestion/{document_id}**: Cancel document ingestion

#### Question Answering Endpoints

- **POST /api/qa/**: Ask a question and get an answer
- **GET /api/qa/history**: Get history of Q&A sessions for a user
- **GET /api/qa/history/{session_id}**: Get a specific Q&A session

#### Document Selection Endpoints

- **POST /api/selection/**: Select documents for Q&A context
- **GET /api/selection/**: Get selected documents for a user

#### Health Check Endpoints

- **GET /**: Root endpoint to verify API is running
- **GET /health**: Health check endpoint with environment info

## Using the Swagger UI

### Testing endpoints

1. Navigate to the Swagger UI URL for the respective service
2. Expand the endpoint you want to test
3. Click "Try it out"
4. Fill in the required parameters
5. Click "Execute"
6. View the response

### Schema Models

Both Swagger UIs provide detailed schema models for all request and response objects at the bottom of the page.

## API Usage Examples

### User Authentication (jarvis-backend)

```json
// POST /auth/login
{
  "username": "admin",
  "password": "password123"
}

// Response
{
  "user": {
    "id": "uuid",
    "username": "admin",
    "email": "admin@example.com",
    "role": "ADMIN"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Document Ingestion (jarvis-datastore)

```json
// POST /api/ingestion/
{
  "document_id": "123e4567-e89b-12d3-a456-426614174000",
  "content_url": "http://localhost:3000/documents/123e4567-e89b-12d3-a456-426614174000/content",
  "metadata": {
    "title": "Example Document",
    "author": "John Doe",
    "created_at": "2023-05-18T10:00:00Z"
  }
}
```

### Asking a Question (jarvis-datastore)

```json
// POST /api/qa/
{
  "question": "What are the key features of the application?",
  "user_id": "user123",
  "document_ids": ["123e4567-e89b-12d3-a456-426614174000"]
}

// Response
{
  "answer": "The key features of the application include document management, RAG-based Q&A, and user authentication...",
  "sources": [
    {
      "document_id": "123e4567-e89b-12d3-a456-426614174000",
      "page_number": 2,
      "text": "The application provides document management, RAG-based Q&A..."
    }
  ]
}
```

## Development Notes

1. Both backends use environment variables for configuration
2. The Swagger documentation automatically updates when API endpoints change
3. Models and DTOs are fully documented using decorators
4. Authentication requirements are clearly marked in the documentation

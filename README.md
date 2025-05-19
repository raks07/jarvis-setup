# Document Management and RAG-based Q&A Application

A comprehensive application for document management with advanced question answering capabilities powered by Retrieval-Augmented Generation (RAG).

## Overview

This application allows users to:

- Upload and manage documents
- Process documents to generate embeddings
- Ask questions and get answers based on the content of the documents
- Manage users and their permissions

## System Architecture

The application consists of three main components across four GitHub repositories:

1. **[jarvis-datastore](https://github.com/raks07/jarvis-datastore)** - Document ingestion and RAG-based Q&A
   - FastAPI framework
   - Processes documents and generates embeddings
   - Provides RAG-based question answering capabilities
   - Includes PostgreSQL with pgvector extension for storing embeddings

2. **[jarvis-backend](https://github.com/raks07/jarvis-backend)** - User and document management
   - User authentication and authorization
   - Role-based access control
   - Document metadata management
   - Coordinates with jarvis-datastore for document ingestion

3. **[jarvis-frontend](https://github.com/raks07/jarvis-frontend)** - User interface
   - Modern, responsive UI built with React and Material-UI
   - Secure authentication flow
   - Document upload and management interface
   - Q&A interface with RAG-based answers

## Features

- **User Management**
  - Register, login, and logout
  - Role-based access control (admin, editor, viewer)
  - User profile management

- **Document Management**
  - Upload documents
  - View and manage document metadata
  - Delete documents

- **Document Ingestion**
  - Process documents to generate embeddings
  - Track ingestion status
  - Manage the ingestion process

- **RAG-based Q&A**
  - Ask questions based on document content
  - Get answers with relevant document excerpts
  - Specify which documents to consider in Q&A

## Getting Started

See the [DEVELOPMENT.md](./DEVELOPMENT.md) file for detailed instructions on setting up and running the application.

## API Documentation

The application provides comprehensive API documentation through Swagger UI and ReDoc interfaces:

### NestJS Backend API (jarvis-backend)

- **Swagger UI**: [http://localhost:3000/api/docs](http://localhost:3000/api/docs)
- Includes authentication, user, document, and ingestion management endpoints

### Python Backend API (jarvis-datastore)

- **Swagger UI**: [http://localhost:8000/api/docs](http://localhost:8000/api/docs)
- **ReDoc**: [http://localhost:8000/api/redoc](http://localhost:8000/api/redoc)
- Includes document ingestion, embedding generation, and RAG-based Q&A endpoints

### Generating Static Documentation

You can generate static HTML documentation using the included script:

```bash
# Ensure both backend services are running
./generate_api_docs.sh
```

This creates a standalone HTML documentation that can be shared and viewed without running the services.

### Quick Start with Docker

The easiest way to run the application is using Docker Compose:

```bash
# Clone the repository
git clone <repository-url>
cd <repository-name>

# Generate a secure JWT secret for authentication
JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
echo "Generated JWT_SECRET: $JWT_SECRET"

# Update the JWT_SECRET in your .env files
sed -i '' "s/JWT_SECRET=.*/JWT_SECRET=$JWT_SECRET/" ../nestjs-backend/.env

# Update the JWT_SECRET in docker-compose.yml
sed -i '' "s/JWT_SECRET=.*/JWT_SECRET=$JWT_SECRET/" docker-compose.yml

# Start the application with Docker Compose
docker-compose up -d
```

## Security Setup

### Generating JWT Secret

For authentication security, you need to generate a strong JWT secret. You can use one of these methods:

```bash
# Using Node.js
JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
echo "Generated JWT_SECRET: $JWT_SECRET"

# Using OpenSSL
JWT_SECRET=$(openssl rand -hex 32)
echo "Generated JWT_SECRET: $JWT_SECRET"

# Update configuration files
sed -i '' "s/JWT_SECRET=.*/JWT_SECRET=$JWT_SECRET/" ../nestjs-backend/.env

### Generating Python Backend SECRET_KEY

For the Python backend security, generate a strong SECRET_KEY:

```bash
# Using Python's secrets module
python3 -c "import secrets; print(secrets.token_hex(32))"

# Update the SECRET_KEY in the .env file
# Replace 'your_secret_key_here' with the generated key
sed -i '' "s/SECRET_KEY=.*/SECRET_KEY=your_generated_key_here/" ../python-backend/.env

sed -i '' "s/- JWT_SECRET=.*$/- JWT_SECRET=$JWT_SECRET/" docker-compose.yml

```

## Technologies Used

- **Python Backend**
  - FastAPI
  - SQLAlchemy
  - pgvector
  - Sentence-Transformers / Hugging Face Transformers

- **NestJS Backend**
  - NestJS
  - TypeScript
  - TypeORM
  - PostgreSQL
  - JWT Authentication

- **React Frontend**
  - React
  - TypeScript
  - Material-UI
  - Redux Toolkit
  - React Router
  - Axios

## License

[MIT License](../LICENSE)

# Development Guide

This document provides instructions for setting up and developing each component of the Document Management and RAG-based Q&A Application.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Getting Started](#getting-started)
3. [jarvis-datastore](#jarvis-datastore)
4. [jarvis-backend](#jarvis-backend)
5. [jarvis-frontend](#jarvis-frontend)
6. [Docker Setup](#docker-setup)
7. [Development Workflow](#development-workflow)

## Project Overview

The application consists of three main components across four GitHub repositories:

1. **[jarvis-datastore](https://github.com/raks07/jarvis-datastore)** - Handles document ingestion, embedding generation, and RAG-based Q&A
2. **[jarvis-backend](https://github.com/raks07/jarvis-backend)** - Manages user authentication and document management
3. **[jarvis-frontend](https://github.com/raks07/jarvis-frontend)** - Provides user interface for all functionalities
4. **[jarvis-setup](https://github.com/raks07/jarvis-setup)** - Contains setup files, documentation, and Docker Compose configuration

## Getting Started

### Prerequisites

- Node.js (v16+)
- Python 3.9+
- Docker and Docker Compose
- PostgreSQL

### Clone the Repository

```bash
git clone <repository-url>
cd jarvis
```

## jarvis-datastore

### Setup

```bash
cd jarvis-datastore  # Clone from https://github.com/raks07/jarvis-datastore

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Edit .env file with your specific settings
```

### Running in Development Mode

```bash
uvicorn app.main:app --reload
```

The API will be available at <http://localhost:8000>.

## jarvis-backend

### Setup

```bash
cd jarvis-backend  # Clone from https://github.com/raks07/jarvis-backend

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env file with your specific settings
```

### Running in Development Mode

```bash
npm run start:dev
```

The API will be available at <http://localhost:3000>.

## jarvis-frontend

### Setup

```bash
cd jarvis-frontend  # Clone from https://github.com/raks07/jarvis-frontend

# Install dependencies
npm install

# Configure environment
cp .env.example .env.local
# Edit .env.local file with your specific settings
```

### Running in Development Mode

```bash
npm run dev
```

The frontend will be available at <http://localhost:5173>.

## Docker Setup

### Running All Services

For a quick start with all components, you can use Docker Compose from the jarvis-setup directory:

```bash
# Navigate to the setup directory
cd jarvis-setup

# Start all services
docker-compose up -d

# Check service logs
docker-compose logs -f

# Stop all services
docker-compose down
```

### Running Individual Services

Each component also has its own docker-compose.yml file for independent development:

**Python Backend with PostgreSQL/pgvector**

```bash
cd python-backend
docker-compose up -d
```

**NestJS Backend with PostgreSQL**

```bash
cd nestjs-backend
docker-compose up -d
```

**React Frontend**

```bash
cd react-frontend
docker-compose up -d
```

## Development Workflow

### Branch Strategy

- `main` - Production-ready code
- `develop` - Integration branch for features
- `feature/*` - Feature branches
- `fix/*` - Bug fix branches

### Commit Guidelines

Follow conventional commits for clear commit messages:

- `feat:` - A new feature
- `fix:` - A bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code changes that neither fix bugs nor add features
- `test:` - Adding or modifying tests
- `chore:` - Changes to the build process or tools

### Testing

Each component has its own testing setup:

**Python Backend**

```bash
cd python-backend
pytest
```

**NestJS Backend**

```bash
cd nestjs-backend
npm run test
```

**React Frontend**

```bash
cd react-frontend
npm run test
```

### Building for Production

**Python Backend**

```bash
# Use the Dockerfile
docker build -t jarvis-python-backend .
```

**NestJS Backend**

```bash
# Build TypeScript
npm run build

# Or use the Dockerfile
docker build -t jarvis-nestjs-backend .
```

**React Frontend**

```bash
# Build
npm run build

# Or use the Dockerfile
docker build -t jarvis-react-frontend .
```

#!/bin/bash

# Script to generate static API documentation from the Swagger endpoints
# Requires the services to be running

# Create output directory
mkdir -p api-docs
echo "Creating API documentation in api-docs directory..."

# Generate HTML for NestJS backend
echo "Generating NestJS API documentation..."
curl http://localhost:3000/api/docs-json -o api-docs/nestjs-api-spec.json
npx swagger-ui-dist-standalone api-docs/nestjs-api-spec.json -o api-docs/nestjs-backend

# Generate HTML for FastAPI backend
echo "Generating FastAPI API documentation..."
curl http://localhost:8000/api/openapi.json -o api-docs/fastapi-api-spec.json
npx swagger-ui-dist-standalone api-docs/fastapi-api-spec.json -o api-docs/fastapi-backend

# Generate combined documentation
echo "Generating combined API documentation..."
npx swagger-merger -i api-docs/nestjs-api-spec.json api-docs/fastapi-api-spec.json -o api-docs/combined-api-spec.json
npx swagger-ui-dist-standalone api-docs/combined-api-spec.json -o api-docs/combined

echo "API documentation generated successfully!"
echo "View the documentation at:"
echo "  - NestJS API: api-docs/nestjs-backend/index.html"
echo "  - FastAPI API: api-docs/fastapi-backend/index.html"
echo "  - Combined API: api-docs/combined/index.html"

# Copy the index HTML file
cp api-docs-index.html api-docs/index.html
echo "  - Documentation Index: api-docs/index.html"

# Make the script executable
chmod +x generate_api_docs.sh

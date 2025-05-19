#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker-compose down

# Remove the postgres-python volume to ensure a clean database setup
echo "Removing postgres-python volume..."
docker volume rm jarvis_postgres-python-data 2>/dev/null || true

# Rebuild the containers with the new changes
echo "Rebuilding containers..."
docker-compose build postgres-python python-backend

# Start the containers
echo "Starting containers..."
docker-compose up -d

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
sleep 10

# Show the logs from the python-backend container to check for errors
echo "Logs from python-backend container:"
docker-compose logs python-backend

echo ""
echo "Setup completed. Your application should now be running with pgvector support!"
echo "You can test it by running:"
echo "curl -X POST \"http://localhost:8000/api/ingestion\" \\"
echo "  -H \"Content-Type: application/json\" \\"
echo "  -d '{\"external_id\": \"doc123\", \"title\": \"Sample Document\", \"content\": \"This is a test document.\"}'"

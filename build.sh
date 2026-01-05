#!/bin/bash

# Script to build Docker image with environment variables from .env file

set -e

# Load .env file
if [ ! -f .env ]; then
    echo "Error: .env file not found"
    exit 1
fi

# Source the .env file
export $(cat .env | grep -v '^#' | xargs)

# Build Docker image with build args from .env
docker build \
    --build-arg MASTER_KEY="${RAILS_MASTER_KEY}" \
    --build-arg PRODUCTION_DB_NAME="${PRODUCTION_DB_NAME}" \
    --build-arg PRODUCTION_DB_USERNAME="${PRODUCTION_DB_USERNAME}" \
    --build-arg CLOUD_SQL_CONNECTION_NAME="${CLOUD_SQL_CONNECTION_NAME}" \
    -t budgetlab:latest \
    .

echo "✓ Docker image built successfully with environment variables from .env"

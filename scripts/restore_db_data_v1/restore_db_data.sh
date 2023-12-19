#!/bin/bash

# PostgreSQL container name in your Docker Compose
POSTGRES_CONTAINER="cdrrmo-ormoc-postgres-1"

# Check if a filename parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Restore the data
echo "Restoring data to the database..."
docker exec -i $POSTGRES_CONTAINER psql -U jay -d cdrrmodb < "$1"

echo "Restore process completed."


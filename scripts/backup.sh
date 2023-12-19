#!/bin/bash

# Set the current date as a timestamp
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Specify the backup directory
BACKUP_DIR="../backup"

# PostgreSQL container name in your Docker Compose
POSTGRES_CONTAINER="cdrrmo-ormoc-postgres-1"

# Run the backup command
docker exec -t $POSTGRES_CONTAINER pg_dumpall -c -U postgres > $BACKUP_DIR/backup_$TIMESTAMP.sql


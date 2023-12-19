#!/bin/bash

# Set the PATH explicitly (adjust as needed)
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Set the current date as a timestamp
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Specify the relative path for the backup directory on the host
# Note: Relative to the script location
BACKUP_DIR="/home/jay/Documents/personal/deploy-cdrrmo/cdrrmo-ormoc/backup"

# Ensure the backup directory exists on the host
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# PostgreSQL container name in your Docker Compose
POSTGRES_CONTAINER="cdrrmo-ormoc-postgres-1"

# Create the backup directory within the container
docker exec -t $POSTGRES_CONTAINER mkdir -p /backup

# Run the backup command without --format option
docker exec -t $POSTGRES_CONTAINER pg_dumpall -c -U jay --file=/backup/backup_$TIMESTAMP.dump

# Copy the backup file from the container to the host
docker cp $POSTGRES_CONTAINER:/backup/backup_$TIMESTAMP.dump $BACKUP_DIR/


#!/bin/bash

# Set the PATH explicitly (adjust as needed)
#export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Set the current date as a timestamp
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

# Specify the relative path for the backup directory on the host
# Note: Relative to the script location
BACKUP_DIR="/home/jay/Documents/personal/deploy-cdrrmo/cdrrmo-ormoc/backup"

# Ensure the backup directory and "uploads" subdirectory exist on the host
if [ ! -d "$BACKUP_DIR/uploads" ]; then
    mkdir -p "$BACKUP_DIR/uploads"
fi

# Set the "backup-latest" directory
BACKUP_LATEST_DIR="/home/jay/Documents/personal/deploy-cdrrmo/cdrrmo-ormoc/backup-latest"

# Create "backup-latest" directory if it doesn't exist
if [ ! -d "$BACKUP_LATEST_DIR/uploads" ]; then
    mkdir -p "$BACKUP_LATEST_DIR/uploads"
fi

# cdrrmo-server container name in your Docker Compose
CDRRMO_SERVER_CONTAINER="cdrrmo-ormoc-cdrrmo-server-1"

# Print the content of /usr/src/app inside the container for debugging
echo "Contents of /usr/src/app inside the container:"
docker exec $CDRRMO_SERVER_CONTAINER ls /usr/src/app

# Copy the uploads folder from the container to the host's "uploads" directory
docker cp $CDRRMO_SERVER_CONTAINER:/usr/src/app/uploads "$BACKUP_DIR/uploads/uploads_$TIMESTAMP"

# Print the contents of the backup directory for debugging
echo "Contents of $BACKUP_DIR/uploads:"
ls "$BACKUP_DIR/uploads"

# Remove old uploads backups from "uploads" directory inside "backup-latest"
find "$BACKUP_LATEST_DIR/uploads" -type d -not -name "uploads_$TIMESTAMP" -exec rm -r {} \;

# Print the contents of "backup-latest/uploads" directory for debugging
echo "Contents of $BACKUP_LATEST_DIR/uploads:"
ls "$BACKUP_LATEST_DIR/uploads"

# Copy the latest uploads backup to the "uploads" directory within "backup-latest"
cp -r "$BACKUP_DIR/uploads/uploads_$TIMESTAMP" "$BACKUP_LATEST_DIR/uploads/"

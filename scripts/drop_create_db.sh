#!/bin/bash

# PostgreSQL container name in your Docker Compose
POSTGRES_CONTAINER="cdrrmo-ormoc-postgres-1"
# Name of the database
DB_NAME="cdrrmodb"

# Function to disconnect from the database
function disconnect_from_database() {
    echo "Disconnecting from the database..."
    docker exec -i $POSTGRES_CONTAINER psql -U jay -d postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$1' AND pg_stat_activity.pid <> pg_backend_pid();"
}

# Function to drop the existing database
function drop_existing_database() {
    echo "Dropping the existing database..."
    docker exec -i $POSTGRES_CONTAINER psql -U jay -d postgres -c "DROP DATABASE IF EXISTS $1;"
}

# Function to create a new database
function create_new_database() {
    echo "Creating a new database..."
    docker exec -i $POSTGRES_CONTAINER psql -U jay -d postgres -c "CREATE DATABASE $1;"
}

# Disconnect from the database (if connected)
disconnect_from_database $DB_NAME

# Drop and create the database
drop_existing_database $DB_NAME
create_new_database $DB_NAME

echo "Drop and create database process completed."


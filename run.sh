#!/bin/bash

# Go to project root
cd "$(dirname "$0")"

# Default database name
DB_NAME="serp_prod"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -db|--db)
            DB_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [-db database_name]"
            exit 1
            ;;
    esac
done

echo "Using database: $DB_NAME"

# Create database if it doesn't exist
if ! psql -lqt | cut -d '|' -f1 | grep -qw "$DB_NAME"; then
    echo "Creating database '$DB_NAME'..."
    createdb "$DB_NAME"

    echo "Importing schema..."
    psql -d "$DB_NAME" -f schema.sql
fi

echo "Starting backend..."

cd backend
npm run dev &
BACKEND_PID=$!

echo "Backend started (PID: $BACKEND_PID)"

sleep 3

echo "Starting frontend..."

cd ../frontend
npm run dev &
FRONTEND_PID=$!

echo "Frontend started (PID: $FRONTEND_PID)"

sleep 5

echo "Opening browser..."

brave-browser http://localhost:5173 >/dev/null 2>&1 &

wait
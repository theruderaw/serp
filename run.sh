#!/bin/bash

# Go to project root (where this script exists)
cd "$(dirname "$0")"

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

brave-browser http://localhost:5173

# Keep script alive
wait
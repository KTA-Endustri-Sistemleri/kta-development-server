#!/bin/bash

APP_NAME=$1

if [ -z "$APP_NAME" ]; then
    echo "❌ Usage: ./dev-frontend.sh <app_name>"
    echo "📦 Example: ./dev-frontend.sh kta_employee"
    exit 1
fi

APP_PATH="/workspace/development/apps/$APP_NAME/frontend"

if [ ! -d "$APP_PATH" ]; then
    echo "❌ Frontend directory not found: $APP_PATH"
    exit 1
fi

cd "$APP_PATH"

echo "📦 Installing dependencies for $APP_NAME..."
yarn install

echo "🚀 Starting Vite dev server for $APP_NAME..."
yarn dev

#!/bin/sh
set -e

echo "🚀 Starting application..."

# Function to wait for database
wait_for_db() {
    echo "⏳ Waiting for database to be ready..."
    local max_retries=30
    local count=0
    
    # Try to push schema. If it fails (DB not ready), wait and retry.
    until npx prisma db push --accept-data-loss; do
        count=$((count+1))
        if [ $count -ge $max_retries ]; then
            echo "❌ Timeout waiting for database after $max_retries attempts."
            exit 1
        fi
        echo "⚠️  Database not ready yet. Retrying in 5 seconds... (Attempt $count/$max_retries)"
        sleep 5
    done
    echo "✅ Database connection established and schema pushed!"
}

if [ -n "$DATABASE_URL" ]; then
    wait_for_db
    
    echo "🌱 Checking/Seeding database..."
    if [ -f "prisma/seed.js" ]; then
        node prisma/seed.js || echo "⚠️ Seed script failed or already seeded"
    fi
else
    echo "⚠️ DATABASE_URL not set, skipping migration."
fi

echo "✅ Ready to start server."
exec node server.js

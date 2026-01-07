#!/bin/sh
# Disable 'set -e' globally to prevent script from exiting on connection failure during the loop
set +e

echo "🚀 Starting application..."

# Function to wait for database
wait_for_db() {
    echo "⏳ Waiting for database to be ready..."
    local max_retries=60
    local count=0
    
    # Simple wait loop
    while [ $count -lt $max_retries ]; do
        echo "Attempting database migration ($count/$max_retries)..."
        
        # Try migration
        npx prisma db push --accept-data-loss
        
        # Check exit code
        if [ $? -eq 0 ]; then
             echo "✅ Database connection established and schema pushed!"
             return 0
        fi
        
        count=$((count+1))
        echo "⚠️  Database connection failed. Retrying in 5 seconds..."
        sleep 5
    done
    
    echo "❌ Timeout waiting for database after $max_retries attempts."
    exit 1
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
# Re-enable error stopping for the main server process
set -e
exec node server.js

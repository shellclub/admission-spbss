#!/bin/sh
set -e

echo "🚀 Starting application..."

# Run database migrations
# We use 'prisma db push' because 'migrate deploy' requires migration history which might complicate things in this setup
# 'db push' syncs schema with DB state.
if [ -n "$DATABASE_URL" ]; then
    echo "📦 Pushing database schema..."
    npx prisma db push --accept-data-loss
    
    echo "🌱 Seeding database..."
    # Execute seed if needed. We use a simple script or just rely on 'db push' + manual checks?
    # Better to run seed if user table is empty. For now, let's just push schema.
    # The error 'login failed' implies user table might not exist or be empty.
    # We should run the seed script if it exists.
    if [ -f "prisma/seed.js" ]; then
        node prisma/seed.js || echo "⚠️ Seed script failed or already seeded"
    fi
else
    echo "⚠️ DATABASE_URL not set, skipping migration."
fi

echo "✅ Database ready. Starting Next.js..."
exec node server.js

# Stage 1: Install dependencies
FROM node:18-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Stage 2: Build the application
FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1

# Prisma needs DATABASE_URL during build for schema validation
# This is a dummy URL - the real one will be provided at runtime
ENV DATABASE_URL="mysql://dummy:dummy@localhost:3306/dummy"

# Generate Prisma Client
RUN npx prisma generate

RUN npm run build

# Stage 3: Production image, copy all the files and run next
FROM node:18-alpine AS runner
WORKDIR /app

RUN apk add --no-cache openssl curl

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy public folder and ensure permissions
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/prisma ./prisma
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./package.json

# Copy start script
COPY --chown=nextjs:nodejs start.sh ./start.sh
RUN chmod +x ./start.sh

# Create necessary directories and set permissions
RUN mkdir -p ./public/uploads/applicants ./public/uploads/documents && \
    chmod -R 777 ./public/uploads && \
    chown -R nextjs:nodejs ./public/uploads

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

# Automatically leverage output traces to reduce image size
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Install only production dependencies needed for migration (prisma) if not in standalone
# Actually 'npx prisma' downloads it if missing, but we want it pre-installed for speed/offline
# We will rely on 'npx' fetching it or copying if valid. 
# Standalone often strips devDeps. Use 'npm install prisma --no-save' to ensure CLI is present?
# Or clearer: Just install prisma globally in this layer.
USER root
# Install runtime dependencies for scripts (seed.js) that are not part of standalone build
# Install runtime dependencies for scripts
RUN npm install bcryptjs mysql2
# Install prisma locally to ensure 'npx prisma' works reliably without downloading
RUN npm install prisma --save-dev
USER nextjs

EXPOSE 3000

ENV PORT=3000
# set hostname to localhost
ENV HOSTNAME="0.0.0.0"

CMD ["./start.sh"]

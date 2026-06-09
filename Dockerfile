# Dependencies Installation Stage
FROM node:24-alpine AS deps
WORKDIR /app
COPY package*.json ./

# Install project dependencies with frozen lockfile for reproducible builds
RUN --mount=type=cache,target=/root/.npm \
    npm install --no-audit --no-fund;

#  Stage 2: Build Next.js application in standalone mode
FROM node:24-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build


# Stage 3: Run Next.js application
FROM node:24-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

USER node

EXPOSE 3000

CMD ["node", "server.js"]

# syntax=docker/dockerfile:1
FROM node:20-alpine AS deps
WORKDIR /app
COPY app/package.json ./
RUN npm install --omit=dev --no-audit --no-fund

FROM node:20-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
RUN apk add --no-cache curl
RUN addgroup -g 1001 app && adduser -D -G app -u 1001 app
COPY --from=deps /app/node_modules ./node_modules
COPY app/ ./
USER app
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -sf http://127.0.0.1:3000/health || exit 1
CMD ["node", "server.js"]

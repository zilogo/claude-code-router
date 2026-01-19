FROM node:20-bookworm-slim AS builder

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.12.2 --activate

COPY pnpm-workspace.yaml pnpm-lock.yaml package.json tsconfig.base.json tsconfig.json ./
COPY scripts ./scripts
COPY packages/core/package.json ./packages/core/
COPY packages/shared/package.json ./packages/shared/
COPY packages/server/package.json ./packages/server/
COPY packages/ui/package.json ./packages/ui/
COPY packages/cli/package.json ./packages/cli/
COPY docs/package.json ./docs/

RUN pnpm install --frozen-lockfile --filter @CCR/server... --filter @CCR/ui...

COPY packages ./packages
COPY docs ./docs

RUN pnpm build:core && pnpm build:shared && pnpm build:server && pnpm build:ui && \
    cp -R packages/ui/dist/. packages/server/dist/

FROM node:20-bookworm-slim

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app /app

EXPOSE 3456

CMD ["node", "packages/server/dist/index.js"]


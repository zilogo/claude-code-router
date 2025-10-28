# Repository Guidelines

## Project Structure & Module Organization
- **`src/`**: TypeScript CLI/runtime. Keep entry points in `cli.ts` and `server.ts`, route logic under `middleware/`, agent orchestration under `agents/`, and shared helpers in `utils/` with exports gathered by local `index.ts`.
- **`ui/`**: React + Vite dashboard compiled to a single HTML file; components follow PascalCase and Tailwind utility classes.
- **`scripts/build.js`** handles esbuild bundling, UI compilation, and copying assets into `dist/`; never commit files generated under `dist/`.
- **Docs & samples**: `blog/` hosts long-form references, `custom-router.example.js` demos extension points, and `logs/` is runtime-only and should stay out of git.

## Build, Test, and Development Commands
- **Install**: `pnpm install` (preferred) or `npm install` in the repo root to sync CLI and UI dependencies.
- **Build**: `npm run build` runs `scripts/build.js`, bundling the CLI, copying `tiktoken_bg.wasm`, and baking the UI into `dist/index.html`.
- **Run CLI**: `node dist/cli.js start` uses `~/.claude-code-router/config.json`; check status with `node dist/cli.js status`.
- **UI dev & lint**: `cd ui && npm run dev` for interactive work, `cd ui && npm run lint` before shipping. Stop the dev server prior to building to free ports.

## Coding Style & Naming Conventions
- Use two-space indentation, `camelCase` for functions, `PascalCase` for components/classes, and `UPPER_SNAKE_CASE` for constants.
- Prefer focused modules with named exports, respect `tsconfig.json` strictness, and avoid editing compiled artifacts.

## Testing Guidelines
- No automated suite yet: add feature-targeted tests alongside new code (e.g., `src/**/__tests__`) and document execution steps in your PR.
- Always run `npm run build`, start the CLI locally, and validate key flows (`ccr start`, `/model` switching, UI connection) against a sample config before review.

## Commit & Pull Request Guidelines
- Mirror the existing imperative commit style (`fix ui bug`, `release v1.0.64`) and keep each commit scoped to one change.
- PRs need a clear summary, linked issues, manual verification notes, and UI screenshots or logs when behavior shifts, plus any configuration or security callouts.

## Security & Configuration Tips
- Reference secrets through environment variables in `config.json` (`$VAR` or `${VAR}`) and keep `.env` files ignored.
- Treat network-facing middleware changes cautiously; verify behind localhost or a proxy before exposing wider access.

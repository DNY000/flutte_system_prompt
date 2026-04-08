import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

/**
 * Absolute path to `tools/prompt-cli/routes.json` when this module is loaded
 * from `tools/prompt-runtime-ts/dist/*.js` (or `src/*.ts` under tsx).
 */
export function defaultRoutesManifestPath(): string {
  const moduleDir = dirname(fileURLToPath(import.meta.url));
  return resolve(moduleDir, "..", "..", "prompt-cli", "routes.json");
}

/**
 * Resolve manifest path: explicit CLI flag > PROMPT_ROUTES_MANIFEST > default next to tools/.
 */
export function resolveRoutesManifestPath(
  cwd: string,
  explicitFromCli?: string,
  envManifest = process.env.PROMPT_ROUTES_MANIFEST
): string {
  const trimmedCli = explicitFromCli?.trim();
  if (trimmedCli) {
    return resolve(cwd, trimmedCli);
  }
  const trimmedEnv = envManifest?.trim();
  if (trimmedEnv) {
    return resolve(cwd, trimmedEnv);
  }
  return defaultRoutesManifestPath();
}

export function repoRootFromManifestPath(manifestPath: string): string {
  return resolve(dirname(manifestPath), "..", "..");
}

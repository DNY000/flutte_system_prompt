import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
/**
 * Absolute path to `tools/prompt-powershell/routes.json` when this module is loaded
 * from `tools/prompt-runtime-typescript/dist/*.js` (or `src/*.ts` under tsx).
 */
export function defaultRoutesManifestPath() {
    const moduleDir = dirname(fileURLToPath(import.meta.url));
    return resolve(moduleDir, "..", "..", "prompt-powershell", "routes.json");
}
/**
 * Resolve manifest path: explicit CLI flag > PROMPT_ROUTES_MANIFEST > default next to tools/.
 */
export function resolveRoutesManifestPath(cwd, explicitFromCli, envManifest = process.env.PROMPT_ROUTES_MANIFEST) {
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
export function repoRootFromManifestPath(manifestPath) {
    return resolve(dirname(manifestPath), "..", "..");
}

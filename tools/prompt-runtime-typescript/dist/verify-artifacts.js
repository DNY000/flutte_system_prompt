import { readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { verifyArtifactMarkdown } from "./artifact-verifier.js";
function repoRoot() {
    const here = dirname(fileURLToPath(import.meta.url));
    return resolve(here, "..", "..", "..");
}
function argValue(args, key) {
    const index = args.indexOf(key);
    if (index < 0)
        return undefined;
    return args[index + 1];
}
function suitePathFromArgs(args) {
    const explicit = argValue(args, "--suite");
    if (explicit?.trim()) {
        return resolve(process.cwd(), explicit);
    }
    return join(repoRoot(), "tools", "prompt-powershell", "evals", "output-artifact-regression.json");
}
function routeContractMap(root) {
    const manifestPath = join(root, "tools", "prompt-powershell", "routes.json");
    const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
    return new Map(manifest.routes.map((route) => [route.routeId, route.outputContract]));
}
function main() {
    const args = process.argv.slice(2);
    const root = repoRoot();
    const suitePath = suitePathFromArgs(args);
    const suite = JSON.parse(readFileSync(suitePath, "utf8"));
    const contractsByRoute = routeContractMap(root);
    const failures = [];
    for (const testCase of suite.cases) {
        const contractId = testCase.outputContract ?? (testCase.routeId ? contractsByRoute.get(testCase.routeId) : undefined);
        if (!contractId) {
            failures.push(`${testCase.caseId}: could not resolve output contract`);
            continue;
        }
        const artifactPath = join(root, testCase.artifactPath);
        const markdown = readFileSync(artifactPath, "utf8");
        const result = verifyArtifactMarkdown(markdown, contractId);
        if (testCase.shouldPass && !result.ok) {
            failures.push(`${testCase.caseId}: expected pass, got errors: ${result.errors.join(" | ")}`);
            continue;
        }
        if (!testCase.shouldPass && result.ok) {
            failures.push(`${testCase.caseId}: expected failure, but verification passed`);
            continue;
        }
        if (!testCase.shouldPass && testCase.expectedErrors?.length) {
            for (const expectedError of testCase.expectedErrors) {
                if (!result.errors.some((error) => error.includes(expectedError))) {
                    failures.push(`${testCase.caseId}: missing expected error substring "${expectedError}" in [${result.errors.join(" | ")}]`);
                }
            }
        }
    }
    if (failures.length > 0) {
        process.stderr.write("output artifact verification: FAILED\n");
        for (const failure of failures) {
            process.stderr.write(`- ${failure}\n`);
        }
        process.exit(1);
    }
    process.stdout.write(`output artifact verification: PASSED (${suite.cases.length} cases)\n`);
}
main();

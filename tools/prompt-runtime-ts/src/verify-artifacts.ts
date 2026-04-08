import { readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { verifyArtifactMarkdown } from "./artifact-verifier.js";
import type { RoutesManifest } from "./types.js";

interface ArtifactSuiteCase {
  caseId: string;
  routeId?: string;
  outputContract?: string;
  artifactPath: string;
  shouldPass: boolean;
  expectedErrors?: string[];
}

interface ArtifactSuite {
  suite: string;
  description?: string;
  cases: ArtifactSuiteCase[];
}

function repoRoot(): string {
  const here = dirname(fileURLToPath(import.meta.url));
  return resolve(here, "..", "..", "..");
}

function argValue(args: string[], key: string): string | undefined {
  const index = args.indexOf(key);
  if (index < 0) return undefined;
  return args[index + 1];
}

function suitePathFromArgs(args: string[]): string {
  const explicit = argValue(args, "--suite");
  if (explicit?.trim()) {
    return resolve(process.cwd(), explicit);
  }
  return join(repoRoot(), "tools", "prompt-cli", "evals", "output-artifact-regression.json");
}

function routeContractMap(root: string): Map<string, string> {
  const manifestPath = join(root, "tools", "prompt-cli", "routes.json");
  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as RoutesManifest;
  return new Map(manifest.routes.map((route) => [route.routeId, route.outputContract] as const));
}

function main(): void {
  const args = process.argv.slice(2);
  const root = repoRoot();
  const suitePath = suitePathFromArgs(args);
  const suite = JSON.parse(readFileSync(suitePath, "utf8")) as ArtifactSuite;
  const contractsByRoute = routeContractMap(root);
  const failures: string[] = [];

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
          failures.push(
            `${testCase.caseId}: missing expected error substring "${expectedError}" in [${result.errors.join(" | ")}]`
          );
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

import { existsSync, readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import type { RoutesManifest } from "./types.js";

interface OutputArtifactSuite {
  cases: Array<{
    caseId: string;
    routeId?: string;
    outputContract?: string;
    artifactPath: string;
  }>;
}

interface SurfaceCatalogItem {
  id: string;
  path: string;
  description: string;
  canonicalRefs: string[];
  routeBias?: string[];
  skills?: string[];
  commands?: string[];
}

interface SurfaceCatalog {
  version: string;
  agents: SurfaceCatalogItem[];
  commands: SurfaceCatalogItem[];
  contexts: SurfaceCatalogItem[];
}

function repoRootFromArgs(): string {
  const args = process.argv.slice(2);
  const idx = args.indexOf("--repo-root");
  if (idx >= 0 && args[idx + 1]) {
    return resolve(args[idx + 1]);
  }
  const here = dirname(fileURLToPath(import.meta.url));
  return resolve(here, "..", "..", "..");
}

function parseContractDocTable(markdown: string): Map<string, string> {
  const map = new Map<string, string>();
  const row = /^\|\s*`([^`]+)`\s*\|\s*`([^`]+)`\s*\|/;
  for (const line of markdown.split(/\r?\n/)) {
    const m = line.match(row);
    if (m) {
      map.set(m[1], m[2]);
    }
  }
  return map;
}

function parseContractSectionNames(markdown: string): Set<string> {
  const names = new Set<string>();
  const re = /^## `([^`]+)`/gm;
  let m: RegExpExecArray | null;
  while ((m = re.exec(markdown)) !== null) {
    names.add(m[1]);
  }
  return names;
}

function validateSurfaceCatalog(repoRoot: string, manifest: RoutesManifest, errors: string[]): void {
  const catalogPath = join(repoRoot, "manifests", "catalog.json");
  const schemaPath = join(repoRoot, "manifests", "catalog.schema.json");
  const validCommands = new Set(["ask", "plan", "review", "execute", "ship-check"]);

  if (!existsSync(catalogPath)) {
    errors.push("Missing operator surface catalog: manifests/catalog.json");
    return;
  }
  if (!existsSync(schemaPath)) {
    errors.push("Missing operator surface schema: manifests/catalog.schema.json");
  }

  const catalog = JSON.parse(readFileSync(catalogPath, "utf8")) as SurfaceCatalog;
  const routeIds = new Set(manifest.routes.map((route) => route.routeId));

  for (const section of ["agents", "commands", "contexts"] as const) {
    const items = catalog[section];
    const seenIds = new Set<string>();
    for (const item of items) {
      if (seenIds.has(item.id)) {
        errors.push(`Surface catalog ${section}: duplicate id ${item.id}`);
      }
      seenIds.add(item.id);

      if (!existsSync(join(repoRoot, item.path))) {
        errors.push(`Surface catalog ${section}/${item.id}: missing path ${item.path}`);
      }
      for (const ref of item.canonicalRefs ?? []) {
        if (!existsSync(join(repoRoot, ref))) {
          errors.push(`Surface catalog ${section}/${item.id}: missing canonicalRef ${ref}`);
        }
      }
      for (const routeId of item.routeBias ?? []) {
        if (!routeIds.has(routeId)) {
          errors.push(`Surface catalog ${section}/${item.id}: unknown routeBias ${routeId}`);
        }
      }
      for (const skillId of item.skills ?? []) {
        const skillFile = join(repoRoot, "docs/ai/11-skills/skills", skillId, "SKILL.md");
        if (!existsSync(skillFile)) {
          errors.push(`Surface catalog ${section}/${item.id}: unknown skill ${skillId}`);
        }
      }
      for (const command of item.commands ?? []) {
        if (!validCommands.has(command)) {
          errors.push(`Surface catalog ${section}/${item.id}: unknown command ${command}`);
        }
      }
    }
  }
}

function main(): void {
  const repoRoot = repoRootFromArgs();
  const errors: string[] = [];
  const manifestPath = join(repoRoot, "tools/prompt-cli/routes.json");
  if (!existsSync(manifestPath)) {
    throw new Error(`Missing manifest: ${manifestPath}`);
  }

  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as RoutesManifest;
  const contractsPath = join(repoRoot, "docs/ai/00-core/contracts/output-contracts.md");
  const contractsMd = readFileSync(contractsPath, "utf8");
  const docRouteTable = parseContractDocTable(contractsMd);
  const contractSections = parseContractSectionNames(contractsMd);

  const routeIds = new Set<string>();
  for (const route of manifest.routes) {
    if (routeIds.has(route.routeId)) {
      errors.push(`Duplicate routeId: ${route.routeId}`);
    }
    routeIds.add(route.routeId);

    if (!route.queryPatterns?.length) {
      errors.push(`Route ${route.routeId}: queryPatterns must be non-empty`);
    }

    const taskPath = join(repoRoot, route.taskPrompt);
    if (!existsSync(taskPath)) {
      errors.push(`Route ${route.routeId}: missing taskPrompt file ${route.taskPrompt}`);
    }

    for (const cf of route.contextFiles ?? []) {
      if (!existsSync(join(repoRoot, cf))) {
        errors.push(`Route ${route.routeId}: missing contextFile ${cf}`);
      }
    }

    for (const skillId of route.skills ?? []) {
      const skillFile = join(repoRoot, "docs/ai/11-skills/skills", skillId, "SKILL.md");
      if (!existsSync(skillFile)) {
        errors.push(`Route ${route.routeId}: missing skill pack ${skillId} (${skillFile})`);
      }
    }

    if (!contractSections.has(route.outputContract)) {
      errors.push(
        `Route ${route.routeId}: outputContract "${route.outputContract}" has no matching section '## \\\`${route.outputContract}\\\`' in output-contracts.md`
      );
    }

    if (docRouteTable.has(route.routeId)) {
      const docContract = docRouteTable.get(route.routeId);
      if (docContract !== route.outputContract) {
        errors.push(
          `Route ${route.routeId}: outputContract in routes.json is "${route.outputContract}" but output-contracts.md table has "${docContract}"`
        );
      }
    } else {
      errors.push(`Route ${route.routeId}: missing row in output-contracts.md routing table`);
    }
  }

  for (const [routeId] of docRouteTable) {
    if (!routeIds.has(routeId)) {
      errors.push(`output-contracts.md table references unknown route_id: ${routeId}`);
    }
  }

  const rubricPath = join(repoRoot, "tools/prompt-cli/evals/task-quality-rubric.md");
  if (!existsSync(rubricPath)) {
    errors.push(`Missing task quality rubric: tools/prompt-cli/evals/task-quality-rubric.md`);
  }
  const qualityThresholdPath = join(repoRoot, "tools/prompt-cli/evals/quality-thresholds.json");
  if (!existsSync(qualityThresholdPath)) {
    errors.push(`Missing quality thresholds: tools/prompt-cli/evals/quality-thresholds.json`);
  }
  const outputArtifactSuitePath = join(repoRoot, "tools/prompt-cli/evals/output-artifact-regression.json");
  if (!existsSync(outputArtifactSuitePath)) {
    errors.push(`Missing output artifact suite: tools/prompt-cli/evals/output-artifact-regression.json`);
  } else {
    const outputArtifactSuite = JSON.parse(readFileSync(outputArtifactSuitePath, "utf8")) as OutputArtifactSuite;
    for (const testCase of outputArtifactSuite.cases) {
      const targetContract =
        testCase.outputContract ??
        (testCase.routeId ? manifest.routes.find((route) => route.routeId === testCase.routeId)?.outputContract : undefined);

      if (testCase.routeId && !routeIds.has(testCase.routeId)) {
        errors.push(`Output artifact suite case ${testCase.caseId}: unknown routeId ${testCase.routeId}`);
      }
      if (!targetContract) {
        errors.push(`Output artifact suite case ${testCase.caseId}: could not resolve output contract`);
      } else if (!contractSections.has(targetContract)) {
        errors.push(`Output artifact suite case ${testCase.caseId}: unknown output contract ${targetContract}`);
      }
      if (!existsSync(join(repoRoot, testCase.artifactPath))) {
        errors.push(`Output artifact suite case ${testCase.caseId}: missing artifactPath ${testCase.artifactPath}`);
      }
    }
  }

  validateSurfaceCatalog(repoRoot, manifest, errors);



  // Ensure each routeId points to a task prompt under docs/ai/02-tasks/
  for (const route of manifest.routes) {
    if (!route.taskPrompt.startsWith('docs/ai/02-tasks/')) {
      errors.push(`Route ${route.routeId}: taskPrompt must live under docs/ai/02-tasks/ (found ${route.taskPrompt})`);
    }
  }

  if (errors.length > 0) {
    process.stderr.write("validate-manifest: FAILED\n");
    for (const e of errors) {
      process.stderr.write(`- ${e}\n`);
    }
    process.exit(1);
  }

  process.stdout.write(
    `validate-manifest: OK (${manifest.routes.length} routes, ${contractSections.size} contract sections, ${docRouteTable.size} table rows, operator surface catalog checked)\n`
  );
}

main();

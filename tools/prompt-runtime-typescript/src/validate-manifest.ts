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

interface FlutterDomainManifest {
  domains: Array<{
    domainId: string;
    sectionId: string;
    sectionIndex: string;
    files: string[];
  }>;
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

function normalizeInlineOptions(value: string): string[] {
  const backticked = [...value.matchAll(/`([^`]+)`/g)].map((match) => match[1].trim()).filter(Boolean);
  if (backticked.length > 0) {
    return backticked;
  }

  return value
    .split(/\s*(?:,|or)\s*/i)
    .map((part) => part.replace(/`/g, "").trim())
    .filter(Boolean);
}

function parseTaskPromptDefaultRoute(markdown: string): { routeIds: string[]; outputContracts: string[] } {
  const routeIds: string[] = [];
  const outputContracts: string[] = [];

  for (const line of markdown.split(/\r?\n/)) {
    const routeMatch = line.match(/^\s*-\s*route:\s+(.+)$/i);
    if (routeMatch) {
      routeIds.push(...normalizeInlineOptions(routeMatch[1]));
    }

    const contractMatch = line.match(/^\s*-\s*output contract:\s+(.+)$/i);
    if (contractMatch) {
      outputContracts.push(...normalizeInlineOptions(contractMatch[1]));
    }
  }

  return {
    routeIds: [...new Set(routeIds)],
    outputContracts: [...new Set(outputContracts)]
  };
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
        const skillFile = join(repoRoot, "docs/ai/skill-system/definitions", skillId, "SKILL.md");
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

function validateFlutterDomainManifest(repoRoot: string, errors: string[]): void {
  const domainManifestPath = join(repoRoot, "tools", "prompt-powershell", "flutter-domains.json");
  if (!existsSync(domainManifestPath)) {
    errors.push("Missing Flutter domain manifest: tools/prompt-powershell/flutter-domains.json");
    return;
  }

  const domainManifest = JSON.parse(readFileSync(domainManifestPath, "utf8")) as FlutterDomainManifest;
  const seenDomainIds = new Set<string>();
  for (const domain of domainManifest.domains) {
    if (seenDomainIds.has(domain.domainId)) {
      errors.push(`Flutter domain manifest: duplicate domainId ${domain.domainId}`);
    }
    seenDomainIds.add(domain.domainId);

    if (!existsSync(join(repoRoot, domain.sectionIndex))) {
      errors.push(`Flutter domain manifest ${domain.domainId}: missing sectionIndex ${domain.sectionIndex}`);
    }

    for (const file of domain.files ?? []) {
      if (!existsSync(join(repoRoot, file))) {
        errors.push(`Flutter domain manifest ${domain.domainId}: missing file ${file}`);
      }
    }
  }
}

function main(): void {
  const repoRoot = repoRootFromArgs();
  const errors: string[] = [];
  const manifestPath = join(repoRoot, "tools/prompt-powershell/routes.json");
  if (!existsSync(manifestPath)) {
    throw new Error(`Missing manifest: ${manifestPath}`);
  }

  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as RoutesManifest;
  const contractsPath = join(repoRoot, "docs/ai/core/contracts/output-contracts.md");
  const contractsMd = readFileSync(contractsPath, "utf8");
  const docRouteTable = parseContractDocTable(contractsMd);
  const contractSections = parseContractSectionNames(contractsMd);
  const structuredSchemasPath = join(repoRoot, "docs/ai/core/contracts/structured-output-schemas.json");
  const structuredSchemas = JSON.parse(readFileSync(structuredSchemasPath, "utf8")) as { contracts?: Record<string, unknown> };
  const schemaContractIds = new Set(Object.keys(structuredSchemas.contracts ?? {}));

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
    } else {
      const taskPrompt = readFileSync(taskPath, "utf8");
      const defaults = parseTaskPromptDefaultRoute(taskPrompt);
      if (defaults.routeIds.length > 0 && !defaults.routeIds.includes(route.routeId)) {
        errors.push(
          `Route ${route.routeId}: task prompt ${route.taskPrompt} does not declare this manifest route in its default route list`
        );
      }
      if (defaults.outputContracts.length > 0 && !defaults.outputContracts.includes(route.outputContract)) {
        errors.push(
          `Route ${route.routeId}: task prompt ${route.taskPrompt} does not declare manifest contract "${route.outputContract}" in its output-contract list`
        );
      }
    }

    for (const cf of route.contextFiles ?? []) {
      if (!existsSync(join(repoRoot, cf))) {
        errors.push(`Route ${route.routeId}: missing contextFile ${cf}`);
      }
    }

    for (const skillId of route.skills ?? []) {
      const skillFile = join(repoRoot, "docs/ai/skill-system/definitions", skillId, "SKILL.md");
      if (!existsSync(skillFile)) {
        errors.push(`Route ${route.routeId}: missing skill pack ${skillId} (${skillFile})`);
      }
    }

    if (!contractSections.has(route.outputContract)) {
      errors.push(
        `Route ${route.routeId}: outputContract "${route.outputContract}" has no matching section '## \\\`${route.outputContract}\\\`' in output-contracts.md`
      );
    } else if (!schemaContractIds.has(route.outputContract)) {
      errors.push(`Route ${route.routeId}: outputContract "${route.outputContract}" is missing from structured-output-schemas.json`);
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

  for (const contractId of contractSections) {
    if (!schemaContractIds.has(contractId)) {
      errors.push(`output-contracts.md contract section is missing structured schema entry: ${contractId}`);
    }
  }

  const rubricPath = join(repoRoot, "tools/prompt-powershell/evals/task-quality-rubric.md");
  if (!existsSync(rubricPath)) {
    errors.push(`Missing task quality rubric: tools/prompt-powershell/evals/task-quality-rubric.md`);
  }
  const qualityThresholdPath = join(repoRoot, "tools/prompt-powershell/evals/quality-thresholds.json");
  if (!existsSync(qualityThresholdPath)) {
    errors.push(`Missing quality thresholds: tools/prompt-powershell/evals/quality-thresholds.json`);
  }
  const outputArtifactSuitePath = join(repoRoot, "tools/prompt-powershell/evals/output-artifact-regression.json");
  if (!existsSync(outputArtifactSuitePath)) {
    errors.push(`Missing output artifact suite: tools/prompt-powershell/evals/output-artifact-regression.json`);
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
  validateFlutterDomainManifest(repoRoot, errors);



  // Ensure each routeId points to a task prompt under docs/ai/tasks/
  for (const route of manifest.routes) {
    if (!route.taskPrompt.startsWith('docs/ai/tasks/')) {
      errors.push(`Route ${route.routeId}: taskPrompt must live under docs/ai/tasks/ (found ${route.taskPrompt})`);
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

import { readFileSync } from "node:fs";
import { evaluateCommandRouteAlignment, parseCommand } from "./commands.js";
import { decideExecutionPolicy } from "./execution-policy.js";
import { repoRootFromManifestPath, resolveRoutesManifestPath } from "./paths.js";
import { persistRuntimeRun } from "./persist-run.js";
import { analyzeRouteResolution } from "./router.js";
import { resolveSkillsByPrecedence } from "./skills.js";
import type { RoutesManifest, RuntimeResult } from "./types.js";

function usage(): never {
  throw new Error(
    [
      "Usage: node dist/index.js --command <ask|plan|review|execute|ship-check> --query \"...\"",
      "  [--project-skills a,b] [--global-skills a,b]",
      "  [--routes path/to/routes.json]  (else PROMPT_ROUTES_MANIFEST or default tools/prompt-powershell/routes.json)",
      "  [--explain]  (include top routing candidates + command/route alignment hints)",
      "  [--persist-run]  (write a structured run artifact under .promptos/runs)"
    ].join("\n")
  );
}

function argValue(args: string[], key: string): string | undefined {
  const idx = args.indexOf(key);
  if (idx < 0) return undefined;
  return args[idx + 1];
}

function csv(value?: string): string[] {
  if (!value) return [];
  return value
    .split(",")
    .map((x) => x.trim())
    .filter(Boolean);
}

function main(): void {
  const args = process.argv.slice(2);
  const commandRaw = argValue(args, "--command");
  const query = argValue(args, "--query");
  if (!commandRaw || !query) usage();

  const command = parseCommand(commandRaw);
  const manifestPath = resolveRoutesManifestPath(process.cwd(), argValue(args, "--routes"));
  const manifest = JSON.parse(readFileSync(manifestPath, "utf8")) as RoutesManifest;
  const routeAnalysis = analyzeRouteResolution(query, manifest);
  const match = routeAnalysis.match;

  const skills = resolveSkillsByPrecedence({
    route: match.route,
    projectSkills: csv(argValue(args, "--project-skills")),
    globalSkills: csv(argValue(args, "--global-skills"))
  });
  const executionPolicy = decideExecutionPolicy(match.route, query);

  const result: RuntimeResult = {
    command,
    routeId: match.route.routeId,
    outputContract: match.route.outputContract,
    riskLevel: match.route.riskLevel,
    routeConfidence: routeAnalysis.confidence,
    clarificationNeeded: routeAnalysis.clarificationNeeded,
    clarificationReason: routeAnalysis.clarificationReason,
    skills,
    matchedPattern: match.matchedPattern,
    executionPolicy
  };

  if (args.includes("--explain")) {
    const alignment = evaluateCommandRouteAlignment(command, match.route);
    result.explain = {
      topCandidates: routeAnalysis.topCandidates.map((c) => ({
        routeId: c.routeId,
        score: c.score,
        matchedPattern: c.matchedPattern
      })),
      commandAlignment: {
        warnings: alignment.warnings,
        hints: alignment.hints
      },
      routeConfidence: {
        level: routeAnalysis.confidence,
        clarificationNeeded: routeAnalysis.clarificationNeeded,
        clarificationReason: routeAnalysis.clarificationReason
      }
    };
  }

  if (args.includes("--persist-run")) {
    persistRuntimeRun(repoRootFromManifestPath(manifestPath), command, query, result);
  }

  process.stdout.write(JSON.stringify(result, null, 2) + "\n");
}

main();

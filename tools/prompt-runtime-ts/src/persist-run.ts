import { createHash, randomUUID } from "node:crypto";
import { mkdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import type { RuntimeResult } from "./types.js";

function requestId(): string {
  return `${new Date().toISOString().replace(/[-:.TZ]/g, "").slice(0, 17)}-${randomUUID().slice(0, 8)}`;
}

function queryHash(query: string): string {
  return createHash("sha256").update(query, "utf8").digest("hex");
}

export function persistRuntimeRun(repoRoot: string, command: string, query: string, result: RuntimeResult): string {
  const runsDir = join(repoRoot, ".promptos", "runs");
  mkdirSync(runsDir, { recursive: true });

  const now = new Date();
  const id = requestId();
  const filename = `${now.toISOString().replace(/[-:]/g, "").replace(/\..+/, "").replace("T", "-")}-${command}-${result.routeId}.json`;
  const record = {
    requestId: id,
    timestamp: now.toISOString(),
    runtime: "prompt-runtime-ts",
    command,
    routeId: result.routeId,
    outputContract: result.outputContract,
    riskLevel: result.riskLevel,
    matchedPattern: result.matchedPattern,
    queryLength: query.length,
    queryHash: queryHash(query),
    skills: result.skills,
    executionPolicy: result.executionPolicy
  };

  const target = join(runsDir, filename);
  writeFileSync(target, JSON.stringify(record, null, 2) + "\n", "utf8");
  return target;
}

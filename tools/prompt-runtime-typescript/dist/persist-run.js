import { createHash, randomUUID } from "node:crypto";
import { mkdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";
function requestId() {
    return `${new Date().toISOString().replace(/[-:.TZ]/g, "").slice(0, 17)}-${randomUUID().slice(0, 8)}`;
}
function queryHash(query) {
    return createHash("sha256").update(query, "utf8").digest("hex");
}
export function persistRuntimeRun(repoRoot, command, query, result) {
    const runsDir = join(repoRoot, ".promptos", "runs");
    mkdirSync(runsDir, { recursive: true });
    const now = new Date();
    const id = requestId();
    const filename = `${now.toISOString().replace(/[-:]/g, "").replace(/\..+/, "").replace("T", "-")}-${command}-${result.routeId}.json`;
    const record = {
        requestId: id,
        timestamp: now.toISOString(),
        runtime: "prompt-runtime-typescript",
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

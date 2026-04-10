import test from "node:test";
import assert from "node:assert/strict";
import { decideExecutionPolicy, suggestMemoryFiles } from "./execution-policy.js";
import type { RouteDef } from "./types.js";

const architectureRoute: RouteDef = {
  routeId: "architecture-decision",
  taskType: "architecture",
  primaryIntent: "architecture.solution",
  outputContract: "architecture-decision-v1",
  taskPrompt: "docs/ai/02-tasks/architecture/architecture.md",
  skills: ["intent-router", "flutter-architect", "context-loader"],
  riskLevel: "high",
  queryPatterns: ["architecture proposal flutter"]
};

const researchRoute: RouteDef = {
  routeId: "research-brief",
  taskType: "research",
  primaryIntent: "research.external",
  outputContract: "research-brief-v1",
  taskPrompt: "docs/ai/02-tasks/engineering/research.md",
  skills: ["intent-router", "research-analyst", "source-validator", "context-loader"],
  riskLevel: "high",
  queryPatterns: ["research"]
};

test("research route requires research and suggests durable memory files when relevant", () => {
  const policy = decideExecutionPolicy(researchRoute, "research the latest flutter package versions");
  assert.equal(policy.researchNeeded, "true");
  assert.equal(policy.mcpNeeded, "false");
  assert.ok(policy.suggestedMemoryFiles.includes("docs/ai/03-memory/glossary.md"));
});

test("architecture route suggests memory and enables memory write when selected", () => {
  const selected = suggestMemoryFiles(architectureRoute, "propose architecture for a feature module");
  const policy = decideExecutionPolicy(architectureRoute, "propose architecture for a feature module", selected);
  assert.equal(policy.memoryWrite, "enabled");
  assert.equal(policy.multiAgentMode, "off");
  assert.ok(selected.includes("docs/ai/03-memory/modules.md"));
  assert.ok(selected.includes("docs/ai/03-memory/decisions.md"));
});

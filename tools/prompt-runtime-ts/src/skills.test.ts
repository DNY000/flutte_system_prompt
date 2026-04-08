import test from "node:test";
import assert from "node:assert/strict";
import { resolveSkillsByPrecedence } from "./skills.js";
import type { RouteDef } from "./types.js";

const sampleRoute: RouteDef = {
  routeId: "code-implement",
  taskType: "code",
  primaryIntent: "code.implement",
  outputContract: "implementation-plan-v1",
  taskPrompt: "docs/ai/02-tasks/code.md",
  skills: ["intent-router", "flutter-coder", "context-loader"],
  riskLevel: "medium",
  queryPatterns: []
};

test("skills ordered project then global-only then built-in-only", () => {
  const result = resolveSkillsByPrecedence({
    route: sampleRoute,
    projectSkills: ["flutter-coder", "intent-router", "business-analyst"],
    globalSkills: ["quality-grader", "flutter-coder"],
    builtInSkills: undefined
  });

  assert.deepEqual(result, [
    "flutter-coder",
    "intent-router",
    "business-analyst",
    "quality-grader",
    "context-loader"
  ]);
});

test("built-in only when no overrides", () => {
  const result = resolveSkillsByPrecedence({
    route: sampleRoute,
    projectSkills: [],
    globalSkills: [],
    builtInSkills: undefined
  });
  assert.deepEqual(result, ["intent-router", "flutter-coder", "context-loader"]);
});

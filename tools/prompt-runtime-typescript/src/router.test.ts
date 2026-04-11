import test from "node:test";
import assert from "node:assert/strict";
import { analyzeRouteResolution, resolveRoute, scorePattern, topRouteCandidates } from "./router.js";
import type { RoutesManifest } from "./types.js";

const miniManifest: RoutesManifest = {
  routes: [
    {
      routeId: "a-first",
      taskType: "test",
      primaryIntent: "t.a",
      outputContract: "review-report-v1",
      taskPrompt: "docs/ai/tasks/engineering/testing.md",
      skills: ["intent-router"],
      riskLevel: "low",
      queryPatterns: ["unlikely phrase one", "x"]
    },
    {
      routeId: "b-second",
      taskType: "test",
      primaryIntent: "t.b",
      outputContract: "review-report-v1",
      taskPrompt: "docs/ai/tasks/engineering/testing.md",
      skills: ["intent-router"],
      riskLevel: "low",
      queryPatterns: ["unlikely phrase two", "x"]
    }
  ]
};

test("scorePattern substring tier beats token-only", () => {
  const s1 = scorePattern("I want alpha beta in my app", "alpha beta");
  const s2 = scorePattern("utterly unrelated zenith", "zenith");
  assert.ok(s1 >= 1000);
  assert.ok(s2 >= 1000);
  assert.ok(s1 > scorePattern("one two three", "alpha beta"));
});

test("resolveRoute picks first route in JSON order on exact tie", () => {
  const m = resolveRoute("x", miniManifest);
  assert.equal(m.route.routeId, "a-first");
});

test("topRouteCandidates respects manifest order on tie", () => {
  const top = topRouteCandidates("x", miniManifest, 5);
  assert.equal(top[0].routeId, "a-first");
  assert.equal(top[1].routeId, "b-second");
});

test("scorePattern handles accented Latin text and maps \\u0111 to d", () => {
  const score = scorePattern("mo\u0111ule d\u00E9sign flutter", "module design flutter");
  assert.ok(score >= 1000);
});

test("analyzeRouteResolution flags ambiguous close matches", () => {
  const manifest: RoutesManifest = {
    routes: [
      {
        routeId: "security-audit",
        taskType: "security",
        primaryIntent: "security.audit",
        outputContract: "review-report-v1",
        taskPrompt: "docs/ai/tasks/engineering/security.md",
        skills: ["intent-router"],
        riskLevel: "medium",
        queryPatterns: ["review security", "security audit"]
      },
      {
        routeId: "performance-audit",
        taskType: "performance",
        primaryIntent: "performance.audit",
        outputContract: "review-report-v1",
        taskPrompt: "docs/ai/tasks/engineering/performance.md",
        skills: ["intent-router"],
        riskLevel: "medium",
        queryPatterns: ["review performance", "performance audit"]
      }
    ]
  };

  const analysis = analyzeRouteResolution("review security and performance", manifest);
  assert.equal(analysis.confidence, "low");
  assert.equal(analysis.clarificationNeeded, true);
  assert.ok(analysis.clarificationReason);
});

test("analyzeRouteResolution marks strong unique substring matches as high confidence", () => {
  const manifest: RoutesManifest = {
    routes: [
      {
        routeId: "state-management-decision",
        taskType: "flutter-decision",
        primaryIntent: "flutter.state_management",
        outputContract: "decision-matrix-v1",
        taskPrompt: "docs/ai/tasks/flutter-decisions/state-management-decision.md",
        skills: ["intent-router"],
        riskLevel: "high",
        queryPatterns: ["provider riverpod auth state"]
      },
      {
        routeId: "package-selection",
        taskType: "flutter-decision",
        primaryIntent: "flutter.package_selection",
        outputContract: "decision-matrix-v1",
        taskPrompt: "docs/ai/tasks/flutter-decisions/package-selection.md",
        skills: ["intent-router"],
        riskLevel: "high",
        queryPatterns: ["choose flutter package"]
      }
    ]
  };

  const analysis = analyzeRouteResolution("provider riverpod auth state", manifest);
  assert.equal(analysis.match.route.routeId, "state-management-decision");
  assert.equal(analysis.confidence, "high");
  assert.equal(analysis.clarificationNeeded, false);
});

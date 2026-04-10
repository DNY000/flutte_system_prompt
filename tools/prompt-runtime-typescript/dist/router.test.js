import test from "node:test";
import assert from "node:assert/strict";
import { resolveRoute, scorePattern, topRouteCandidates } from "./router.js";
const miniManifest = {
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

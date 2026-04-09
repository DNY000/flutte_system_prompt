# Skill execution pipeline (end-to-end steps)

Single page describing **order of operations** so skills, context, and constraints compose predictably. Use this when debugging “the agent skipped a step” or “context was too thin.”

## 1. Request ingress

| Step | Actor | Output |
| --- | --- | --- |
| 1.1 | Host / hook `pre-route` | Normalized text, stripped unsafe payloads |
| 1.2 | `intent-router` | `route_id`, `primary_intent`, `output_contract`, `risk_level` |
| 1.3 | Hook `post-route` | Confidence check; escalate risk if signals mismatch |

**Constraints:** one primary `route_id` per user turn unless explicitly multi-part mission.

## 2. Skill resolution

| Step | Source | Output |
| --- | --- | --- |
| 2.1 | `routes.json` → `skills[]` | Ordered `skill_id` list for route |
| 2.2 | `skill-precedence-policy.md` | Merge project > global > built-in overrides |
| 2.3 | `skill-registry.md` | Confirm each id maps to a role |

## 3. Context assembly

| Step | Skill / doc | Output |
| --- | --- | --- |
| 3.1 | `context-loader` | Ordered file list: core → task → `project-context` → optional guides |
| 3.2 | `context-loading-rules.md` | Cap sprawl: one task prompt; index before leaf packs |
| 3.3 | Optional | `08-guides/flutter/index.md` then **one** domain file |

**Constraints:** do not load all memory files; summarize before injecting large excerpts.

## 4. Execution

| Step | Action | Output |
| --- | --- | --- |
| 4.1 | Hook `pre-execute` | Required context present; contract id set |
| 4.2 | Specialist skills | Plan / code / review per active `SKILL.md` steps |
| 4.3 | `source-validator` | When research or versions cited |
| 4.4 | `mcp-orchestrator` | When repo or tool data needed and allowed |

## 5. Verification

| Step | Actor | Output |
| --- | --- | --- |
| 5.1 | `quality-grader` or rubric | Scores when eval / gate |
| 5.2 | Hook `post-execute` | Telemetry, quality checklist |
| 5.3 | Tests / analyzer | For code routes, prefer real commands |

## 6. Memory and regression

| Step | Actor | Output |
| --- | --- | --- |
| 6.1 | `memory-curator` | Proposal only after durable decision |
| 6.2 | `04-templates/resolved-issue-memory.md` | Incidents → `03-memory/` |
| 6.3 | Evals | New case if routing or contract failed |

## 7. Release gate (optional)

| Step | Hook | Output |
| --- | --- | --- |
| 7.1 | `pre-release-gate` | `npm run validate-manifest`, evals, checklist |

---

## Quick matrix: route family → typical skills → contract

| Route family (examples) | Typical skills | Typical contract |
| --- | --- | --- |
| Implementation / `code` | `flutter-coder`, `test-engineer` | `implementation-plan-v1` |
| Architecture | `flutter-architect`, `module-designer` | `architecture-decision-v1` |
| UI design | `flutter-ui-designer` | `design-spec-v1` |
| Decision | `flutter-decision-analyst`, `research-analyst` | `decision-matrix-v1` |
| Security / perf | `security-auditor`, `performance-analyst` | `review-report-v1` |
| Prompt / agent / eval | `prompt-architect`, `agent-architect`, `eval-designer` | roadmap / eval artifacts |

Exact mapping is defined per route in `02-tasks/*.md` and `routes.json`.

# Detailed Audit Report — Folders 2 → 6

**Repo:** `DNY000/flutte_system_prompt` | **Ref:** `main` | **Audit date:** 2026-04-08

---

## Table of Contents

- [Folder 2 — `agent/`](#folder-2--agent)
- [Folder 3 — `tools/`](#folder-3--tools)
- [Folder 4 — `docs/`](#folder-4--docs)
- [Folder 5 — `missions/`](#folder-5--missions)
- [Folder 6 — `playground/`](#folder-6--playground)

---

## Folder 2 — `agent/`

**Purpose:** Orchestration layer of the Flutter/mobile prompt OS — ties together route resolution, skill activation, context loading, and output contract enforcement into a single execution loop.

### File inventory

| # | File | Approx. size |
|---|------|--------------|
| 1 | `agent/README.md` | ~60 lines |
| 2 | `agent/SKILLS.md` | ~60 lines |

---

### Per-file analysis

#### `agent/README.md`

**Role & purpose:**
Entry-point documentation for the agent layer. Covers:
- Four entry points (Skill index, PowerShell CLI, TypeScript runtime, `.promptos/` runtime state).
- "No duplication" rule: skill definitions live **only** in `docs/ai/11-skills/skills/<id>/SKILL.md`.
- Agent roles (ask/plan/execute/review) are *profiles* that combine skills — they are not standalone `skill_id` entries in `routes.json`.
- Note on the future Hermes-style loop.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear entry-point table, well-layered |
| Maintainability | ✅ "No duplication" constraint is explicit and easy to enforce |
| Security | ✅ No secrets or processing logic — low risk |
| Standardization | ⚠️ No version header or "last updated" date |

**Strengths:**
- Architectural intent is clear: separates orchestration (agent) from definitions (docs).
- Future roadmap note (Hermes loop) keeps long-term vision visible without cluttering present.

**Weaknesses:**
- No update date — hard to detect when the entry-point table becomes stale.
- The "future" Hermes section has no linked issue/milestone to track progress.

**Improvement recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Add `> Last updated: YYYY-MM-DD` at the top of the file |
| P2 | Link the Hermes-style loop section to a GitHub issue or milestone |
| P3 | Add a 2–3 step quickstart (resolve → build → run) inline to reduce onboarding friction |

---

#### `agent/SKILLS.md`

**Role & purpose:**
Single navigation page (Table of Contents) for the entire skill registry. Divided into three groups:
1. **Core skills** (6): intent-router, context-loader, memory-curator, mcp-orchestrator, quality-grader, source-validator.
2. **Specialist skills** (19): Flutter & mobile delivery.
3. **AI-system skills** (3): prompt-architect, agent-architect, eval-designer.

Each entry is a direct link to `docs/ai/11-skills/skills/<id>/SKILL.md`.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear groupings, easy-to-scan Markdown tables |
| Maintainability | ⚠️ Manual links — adding a new skill requires updates in 3+ places (here, `routes.json`, skill-registry.md) |
| Security | ✅ No direct security risk |
| Standardization | ⚠️ No automated stale-link check |

**Strengths:**
- Single navigation source: new contributors only need this file to discover all skills.
- Consistent format with `routes.json` (same `skill_id` values).

**Weaknesses:**
- 28 skills listed with no one-line description — must click every link to understand what a skill does.
- Drift is likely if a skill is added to `docs/ai/11-skills` without updating this file.

**Improvement recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Add a "Short description" column (1 line) to each table |
| P1 | Add a CI check in `validate-manifest` to detect skills that have a `SKILL.md` but are missing from `SKILLS.md` |
| P2 | Add a version/date header consistent with `README.md` |

---

### Folder 2 summary

| Criterion | Score |
|-----------|-------|
| Structure | 4/5 |
| Maintainability | 3/5 |
| Security | 5/5 |
| Standardization | 3/5 |
| **Total** | **15/20** |

---

## Folder 3 — `tools/`

**Purpose:** Runtime execution tooling for the prompt system — PowerShell CLI (`prompt-cli/`) and TypeScript runtime (`prompt-runtime-ts/`). This is the "execution engine" of the entire system.

### File inventory

#### `tools/prompt-cli/`

| # | File | Summary |
|---|------|---------|
| 1 | `README.md` | Full CLI documentation |
| 2 | `aiprompt.ps1` | Main CLI (737-line PowerShell script) |
| 3 | `routes.json` | Route manifest — single source of truth |
| 4 | `flutter-domains.json` | Flutter domain map for context loading |
| 5 | `run-evals.ps1` | Runs all eval gates |
| 6 | `evals/benchmark-dataset.json` | Golden route resolution cases |
| 7 | `evals/route-regression.json` | Route regression test cases |
| 8 | `evals/contract-compliance.json` | Contract compliance checks |
| 9 | `evals/multilingual-routing-benchmark.json` | Multi-language routing benchmark |
| 10 | `evals/quality-thresholds.json` | Quality thresholds by route family |
| 11 | `evals/task-quality-rubric.md` | Output scoring rubric |
| 12 | `evals/telemetry-schema.json` | Telemetry log entry schema |
| 13 | `evals/trend-baseline.json` | Trend metric baseline |

#### `tools/prompt-runtime-ts/`

| # | File | Summary |
|---|------|---------|
| 14 | `package.json` | Node.js manifest |
| 15 | `tsconfig.json` | TypeScript compiler config |
| 16 | `package-lock.json` | Dependency lockfile |
| 17 | `src/types.ts` | System type definitions |
| 18 | `src/router.ts` | Routing logic (score pattern, resolve) |
| 19 | `src/skills.ts` | Skill precedence resolution |
| 20 | `src/commands.ts` | Command policies and alignment |
| 21 | `src/index.ts` | TypeScript CLI entry point |
| 22 | `src/normalize.ts` | Text normalization (ASCII fold) |
| 23 | `src/paths.ts` | Manifest path resolution |
| 24 | `src/validate-manifest.ts` | Manifest validation gate |
| 25 | `src/router.test.ts` | Unit tests for router |
| 26 | `src/skills.test.ts` | Unit tests for skill precedence |

---

### Per-file analysis

#### `tools/prompt-cli/README.md`

**Role:** The most complete documentation in the repo — covers install, every command (list-routes, resolve, show-route, build), Flutter decision examples, eval gates, and the TypeScript runtime.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear sections, complete code block examples |
| Maintainability | ⚠️ Windows (`.\aiprompt.ps1`) vs macOS (`pwsh ./aiprompt.ps1`) paths need to stay in sync when new commands are added |
| Security | ✅ No secrets exposed |
| Standardization | ✅ Consistent with `routes.json` and the PowerShell script |

**Strengths:** Best onboarding document in the repo; covers everything from install to eval gates.

**Weaknesses:** No "30-second quick start" at the top — readers must scan multiple sections to get started.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Add a "Quick Start (30s)" section immediately after install instructions |
| P3 | Add a sample JSON output block for `resolve -Json` so new contributors understand the output shape |

---

#### `tools/prompt-cli/aiprompt.ps1`

**Role:** 737-line main CLI — handles 5 commands: `help`, `list-routes`, `resolve`, `show-route`, `build`. Performs scoring via token overlap + ASCII folding, loads context files from routes/domains manifests, builds prompt packages, supports clipboard and file output.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ `Set-StrictMode`, `$ErrorActionPreference = 'Stop'`, well-separated functions |
| Maintainability | ⚠️ 737-line single file — long functions, hard to unit-test individual helpers in PowerShell |
| Security | ✅ No dynamic shell execution; no user-input eval |
| Standardization | ✅ Algorithm parity with the TypeScript router (`scorePattern`) — documented |

**Strengths:**
- `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'` — good for early error detection.
- Clear parity intent with the TS router.
- Cross-platform support (Windows + macOS via `pwsh`).

**Weaknesses:**
- 737 lines in a single file → hard to test individual functions in isolation.
- Zero Pester tests for `aiprompt.ps1`.
- Some hardcoded Windows backslashes (`'docs\ai'`) — may cause issues on Unix despite `Join-Path` usage elsewhere.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Add Pester tests for the scoring function and route resolution logic |
| P2 | Extract modules: `router.psm1`, `builder.psm1` for easier testing and maintenance |
| P2 | Audit and replace hardcoded backslashes with `Join-Path` consistently |
| P3 | Add `#Requires -Version 7.0` or an explicit PowerShell version check |

---

#### `tools/prompt-cli/routes.json`

**Role:** Single source of truth for all route definitions — declares `routeId`, `taskType`, `primaryIntent`, `outputContract`, `taskPrompt`, `skills[]`, `riskLevel`, `queryPatterns[]`, and optional `contextFiles[]` per route.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Consistent schema; all required fields present |
| Maintainability | ✅ Validated by `validate-manifest.ts` — solid CI gate |
| Security | ✅ Config data only; no embedded logic |
| Standardization | ✅ `primaryIntent` follows the taxonomy from `routing-rules.md` |

**Strengths:**
- Every route is automatically validated (file existence, skill SKILL.md presence, contract match with docs).
- Flat JSON structure is easy to query and extend.

**Weaknesses:**
- No companion JSON Schema file (`.schema.json`) — IDEs cannot validate automatically.
- `queryPatterns` are raw strings — no mechanism to detect overlap or conflicts between routes.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Create `routes.schema.json` and add a `$schema` field → IDE autocomplete and validation |
| P2 | Add a check in `validate-manifest` to warn when two routes have identical patterns |
| P3 | Add a short `description` field per route so IDEs and docs can auto-render summaries |

---

#### `tools/prompt-cli/flutter-domains.json`

**Role:** Flutter domain map — maps `domainId` → `sectionId`, `sectionIndex`, `routeHints`, `queryPatterns`, `files[]`. Used by `aiprompt.ps1` when building context packages per domain.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Consistent schema |
| Maintainability | ⚠️ No automated validation that referenced domain files actually exist |
| Security | ✅ Pure config data |
| Standardization | ⚠️ No companion JSON Schema |

**Strengths:** Domain mapping is cleanly separated from the route manifest — easy to extend.

**Weaknesses:** `files[]` entries in each domain are not checked by `validate-manifest` → silent stale references after docs restructuring.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Extend `validate-manifest.ts` to verify every path listed in `files[]` within `flutter-domains.json` |
| P2 | Create `flutter-domains.schema.json` |

---

#### `tools/prompt-cli/run-evals.ps1`

**Role:** Runs all eval gates: route regression, multilingual routing, contract compliance, doc sync, threshold/baseline sanity. This is the primary CI guard for the prompt system.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ `Set-StrictMode`, clear function separation, collects errors into a list then reports at the end |
| Maintainability | ⚠️ PowerShell-only — CI runners must have `pwsh` installed |
| Security | ✅ No dynamic execution; reads local files only |
| Standardization | ✅ Integrated with `.github/workflows/prompt-evals.yml` |

**Strengths:** Comprehensive — validates routes → contracts → doc sync → thresholds in one pass.

**Weaknesses:**
- Exit code convention (0/1) needs verification and documentation.
- No per-query timeout when calling `aiprompt.ps1` (evals slow down as test cases grow).

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Verify and document exit code convention (0 = pass, 1 = fail) |
| P2 | Add a per-query timeout (`-TimeoutSec`) to `Resolve-RouteId` calls |
| P3 | Add a summary report format (pass/fail counts, % pass rate) for cleaner CI logs |

---

#### `tools/prompt-cli/evals/route-regression.json`

**Role:** Golden test cases — each `(query, expectedRouteId)` pair is a regression guard ensuring route resolution is not broken when `queryPatterns` are changed.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Simple schema with clear intent |
| Maintainability | ✅ Easy to add new cases |
| Security | ✅ Test data, no risk |
| Standardization | ✅ `suite` field for identification |

**Strengths:** Safety net for `queryPatterns` refactoring.

**Weaknesses:** No coverage metric — unknown what percentage of routes have a golden case.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Add a check in `run-evals.ps1` that warns when a route has no golden case |
| P2 | Add an optional `notes` field to record why a specific query was chosen |

---

#### `tools/prompt-cli/evals/contract-compliance.json`

**Role:** Verifies that each `routeId` → `outputContract` mapping is consistent between `routes.json` and `output-contracts.md`.

**Recommendation:** P2 — Add cases for orphan contract detection (contracts that have a section in `output-contracts.md` but are not referenced by any route).

---

#### `tools/prompt-cli/evals/multilingual-routing-benchmark.json`

**Role:** Routing benchmark with multi-language queries — ensures text normalization works correctly for Vietnamese, Japanese, etc.

**Strengths:** Rarely seen in prompt systems — high value for globalization.

**Recommendation:** P2 — Add more Vietnamese query cases since this is the primary usage context.

---

#### `tools/prompt-cli/evals/quality-thresholds.json`

**Role:** Defines minimum quality thresholds by route family (`decision`: 2.8, `implementation`: 3.0, etc.) and `minimumCriterionFloor: 2.0`.

**Strengths:** Thresholds are decoupled from logic → easy to tune without touching code.

**Weaknesses:** `manualQualityAverage: null` in `trend-baseline.json` — never measured in practice.

**Recommendation:** P1 — Establish a rubric scoring process and populate `manualQualityAverage`.

---

#### `tools/prompt-cli/evals/task-quality-rubric.md`

**Role:** Output scoring rubric (0–4) across 7 criteria with per-family weights.

**Strengths:** Clear rubric with scale and pass guidance.

**Weaknesses:** No concrete examples for each score level (e.g., "what does a score-2 decision quality response look like").

**Recommendation:** P2 — Add at least one example for score 2 and score 4 per criterion.

---

#### `tools/prompt-cli/evals/telemetry-schema.json`

**Role:** Descriptive JSON Schema for telemetry log entries — defines `requiredFields` and `optionalFields`.

**Weakness:** Descriptive only; no validator is integrated to check that actual logs comply.

**Recommendation:** P3 — Integrate telemetry schema validation into `run-evals.ps1`.

---

#### `tools/prompt-cli/evals/trend-baseline.json`

**Role:** Stores baseline metrics by version — `routeRegressionPassRate: 1.0`, `contractCompliancePassRate: 1.0`, `manualQualityAverage: null`.

**Weakness:** `manualQualityAverage: null` — not filled in after the first scoring cycle.

**Recommendation:** P1 — Populate `manualQualityAverage` after the first rubric scoring cycle.

---

#### `tools/prompt-runtime-ts/package.json`

**Role:** Node.js manifest — defines scripts (`build`, `check`, `test`, `validate-manifest`), devDependencies (`typescript ~6.0.2`, `@types/node ~22.19.17`).

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ `"private": true` prevents accidental publish; `"type": "module"` consistent with ESM |
| Maintainability | ✅ Tilde range (`~`) pins the minor version |
| Security | ✅ Only devDependencies — zero runtime attack surface |
| Standardization | ✅ Script names match documentation |

**Strengths:** Minimal dependencies (TypeScript + @types/node only) — zero runtime attack surface.

**Weaknesses:** TypeScript `~6.0.2` is a very recent version — stability should be verified.

**Recommendation:** P2 — Add `"engines": { "node": ">=20" }` to pin the Node.js version requirement.

---

#### `tools/prompt-runtime-ts/tsconfig.json`

**Role:** TypeScript compiler config — `strict: true`, `target: ES2020`, `module: NodeNext`, `outDir: dist`.

**Quality:** ✅ Strict mode on; `NodeNext` module resolution is correct for ESM. `skipLibCheck: true` is pragmatic but can hide type errors from libraries.

**Recommendation:** P3 — Consider disabling `skipLibCheck` once the TypeScript version stabilizes to catch errors earlier.

---

#### `tools/prompt-runtime-ts/src/types.ts`

**Role:** Central type definitions — `RouteDef`, `RoutesManifest`, `RouteMatch`, `RuntimeCommand`, `CommandPolicy`, `RuntimeExplain`, `RuntimeResult`.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Types-only file; no logic |
| Maintainability | ✅ Single source of truth for the type system |
| Security | ✅ No risk |
| Standardization | ✅ `RiskLevel` is a union type, not a magic string |

**Strengths:** Good type-first architecture — changing data shape produces compile errors immediately.

**Weaknesses:** `contextFiles?: string[]` in `RouteDef` is optional — code that depends on it needs defensive checks.

**Recommendation:** P3 — Add short JSDoc comments to each interface.

---

#### `tools/prompt-runtime-ts/src/router.ts`

**Role:** Core routing logic — `scorePattern()`, `bestScoresPerRoute()`, `topRouteCandidates()`, `resolveRoute()`. Maintains parity with the PowerShell `aiprompt.ps1` router.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Pure functions; no side effects |
| Maintainability | ✅ Each function has JSDoc; logic is small |
| Security | ✅ No execution or dynamic eval |
| Standardization | ✅ Algorithm documented in `routing-algorithm.md` |

**Strengths:** Pure functions are easy to test; no mutation. Tie-breaking is explicit (manifest order).

**Weaknesses:** `scorePattern` formula (`matches * 10 - penalty`) has no tests for edge cases (empty query, Unicode input).

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Add test cases: empty query, Unicode query, single-token query |
| P2 | Extract scoring magic numbers (1000, 10) into named constants |

---

#### `tools/prompt-runtime-ts/src/skills.ts`

**Role:** `resolveSkillsByPrecedence()` — merges skill lists in order project > global > built-in, deduplicating via `Set`.

**Quality:** ✅ Simple logic, well-tested, clear JSDoc.

**Strengths:** Dedup-by-first-occurrence behavior is documented and tested.

**Weaknesses:** No validation of `skillId` format (no whitespace, lowercase-kebab expected).

**Recommendation:** P3 — Add an assertion or warning when a `skillId` does not match `[a-z0-9-]+`.

---

#### `tools/prompt-runtime-ts/src/commands.ts`

**Role:** `COMMAND_POLICIES[]` — maps commands (`ask/plan/review/execute/ship-check`) to preferred task types and contracts. `evaluateCommandRouteAlignment()` generates warnings/hints. `parseCommand()` validates input.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Data-driven policies; logic is separate |
| Maintainability | ✅ Adding a command = one new entry in the array |
| Security | ✅ `parseCommand` throws on invalid command |
| Standardization | ✅ Policies consistent with `command-routing-map.md` |

**Weakness:** No unit test for `evaluateCommandRouteAlignment`.

**Recommendation:** P1 — Add tests for `evaluateCommandRouteAlignment` (warning path vs. hint path).

---

#### `tools/prompt-runtime-ts/src/index.ts`

**Role:** CLI entry point — parses args, loads manifest, resolves route, resolves skills, builds `RuntimeResult`, outputs JSON.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Parse / resolve / output clearly separated |
| Maintainability | ⚠️ Manual arg parsing (no `commander` or yargs) — error-prone when adding new flags |
| Security | ✅ No dynamic execution; paths resolved via `paths.ts` |
| Standardization | ✅ Usage string is complete |

**Weakness:** `usage()` throws an `Error` instead of calling `process.exit(1)` — can be silently caught upstream.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Replace `throw` in `usage()` with `process.stderr.write(usageMsg)` + `process.exit(1)` |
| P2 | Consider migrating to Node.js built-in `parseArgs` to avoid manual `indexOf` |
| P3 | Add `--version` flag |

---

#### `tools/prompt-runtime-ts/src/normalize.ts`

**Role:** `normalizeText()` — NFD decompose → strip accents → lowercase → replace non-alphanumeric with space → trim.

**Quality:** ✅ Pure function; no side effects. Handles Vietnamese/accented input correctly via NFD.

**Strengths:** Minimal and technically correct.

**Weaknesses:** No dedicated unit tests for `normalizeText` — only tested indirectly through router tests.

**Recommendation:** P2 — Add direct unit tests for `normalizeText` (Vietnamese input, CJK characters, emoji).

---

#### `tools/prompt-runtime-ts/src/paths.ts`

**Role:** `defaultRoutesManifestPath()` — resolves the path to `routes.json` from the `dist/` directory. `resolveRoutesManifestPath()` — priority: CLI flag > env `PROMPT_ROUTES_MANIFEST` > default.

**Quality:** ✅ Resolution chain is clear and documented in README. `fileURLToPath(import.meta.url)` is correct for ESM.

**Weakness:** Does not validate that the resolved path exists (validation happens in `index.ts` on `readFileSync`).

**Recommendation:** P3 — Add unit tests for `resolveRoutesManifestPath` covering the env variable scenario.

---

#### `tools/prompt-runtime-ts/src/validate-manifest.ts`

**Role:** Comprehensive manifest validator — checks: duplicate `routeId`, empty `queryPatterns`, file existence (taskPrompt, contextFiles, skill SKILL.md), contract section in `output-contracts.md`, doc table sync, `taskPrompt` prefix, rubric/threshold file existence.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Collect-all-errors pattern (not fail-fast) — reports all errors at once |
| Maintainability | ✅ Each check is a self-contained block — easy to add or remove |
| Security | ✅ Read-only; no file writes |
| Standardization | ✅ Exits with code 1 on failure — CI-friendly |

**Strengths:** Most important safety net in the entire system — prevents broken references from reaching production.

**Weaknesses:** Does not validate `flutter-domains.json` `files[]` — see the flutter-domains.json section.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Extend to validate every path in `flutter-domains.json` `files[]` |
| P1 | Add a check that `agent/SKILLS.md` lists all skills referenced in `routes.json` |
| P2 | Add unit tests for `parseContractDocTable` and `parseContractSectionNames` |

---

#### `tools/prompt-runtime-ts/src/router.test.ts` and `skills.test.ts`

**Role:** Unit tests using Node.js built-in `node:test` — no external test framework required.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Mini-manifest pattern (no filesystem dependency) |
| Maintainability | ✅ Assertions are clear; test names are descriptive |
| Security | ✅ No risk |
| Standardization | ✅ `node:test` + `node:assert/strict` — zero external dependency |

**Strengths:** Zero external test dependency — runs immediately with any Node.js install.

**Weaknesses:** Low coverage — `commands.ts` and `normalize.ts` have no tests.

**Recommendation:** P1 — Add tests for `commands.ts` and `normalize.ts`.

---

### Folder 3 summary

| Criterion | Score |
|-----------|-------|
| Structure | 5/5 |
| Maintainability | 3/5 |
| Security | 5/5 |
| Standardization | 4/5 |
| **Total** | **17/20** |

---

## Folder 4 — `docs/`

**Purpose:** The full knowledge base of the system — system prompt, routing rules, skill definitions, memory, templates, Flutter guides, roadmap, releases. This is the "brain" of the system — approximately 80% of total repo files.

### Directory structure

```
docs/ai/
├── 00-core/          (24 files) — Core engine rules
├── 01-context/       (1 file)   — Project context
├── 02-tasks/         (24 files) — Task prompts per route
├── 03-memory/        (6 files)  — Memory layer
├── 04-templates/     (4 files)  — Output templates
├── 05-index/         (1 file)   — Query index
├── 06-examples/      (1 file)   — Route examples
├── 07-references/    (1 file)   — Source map
├── 08-guides/        (~50 files)— Flutter & AI system guides
├── 09-roadmap/       (7 files)  — Dev roadmap & task backlog
├── 10-releases/      (2 files)  — Changelog
├── 11-skills/        (~35 files)— Skill definitions
└── README.md + prompt-system-blueprint.md
```

---

### Per-subfolder analysis

#### `docs/ai/00-core/` — Core Engine (24 files)

**Overview:** The most critical layer — defines AI agent behavior at the lowest level.

| File | Role | Quality |
|------|------|---------|
| `system-prompt.md` | Root system prompt — identity, global rules, execution order, output format | ✅ Clear; numbered execution order |
| `rules.md` | Full ruleset | ✅ Comprehensive |
| `rules_1k.md` | 1K-token condensed version | ✅ For short contexts |
| `rules_4k.md` | 4K-token condensed version | ✅ |
| `rules_10k.md` | Full 10K-token version | ✅ |
| `routing-rules.md` | Intent taxonomy, route schema | ✅ Reference for `routes.json` |
| `routing-algorithm.md` | Detailed scoring algorithm | ✅ Parity reference for PS and TS |
| `decision-engine.md` | Decision logic for complex tasks | ✅ |
| `answer-policies.md` | Answer policies: depth, format, assumptions | ✅ |
| `output-contracts.md` | All output contract definitions | ✅ Single source of truth for contracts |
| `output-rules.md` | Output format rules | ✅ |
| `skill-registry.md` | Registry and activation rules | ✅ |
| `skill-contracts.md` | Per-skill contracts | ✅ |
| `skill-precedence-policy.md` | Skill precedence policy | ✅ |
| `context-loading-rules.md` | Context loading rules | ✅ |
| `memory-write-policy.md` | Memory write policy | ✅ |
| `mcp-research-policy.md` | MCP/research usage policy | ✅ |
| `observability-policy.md` | Logging/observability policy | ✅ |
| `operating-model.md` | Overall operating model | ✅ |
| `response-depth-policy.md` | Response depth policy | ✅ |
| `token-rules.md` | Token budget rules | ✅ |
| `prompt-versioning-policy.md` | Prompt versioning policy | ✅ |
| `prompt-release-checklist.md` | Prompt release checklist | ✅ |
| `self-analysis-protocol.md` | Self-analysis protocol | ✅ |

**Strengths:**
- Policies are cleanly separated by function (not stuffed into one file).
- Three token-tiered variants (1K/4K/10K) of the rules — flexible for different context window sizes.
- Cross-references between files (routing-algorithm.md ↔ routing-rules.md ↔ routes.json).

**Weaknesses:**
- No index or summary for `00-core` to guide new contributors on which files to read first.
- No version header to distinguish which `rules.md` variant is the authoritative source.
- Most files lack a date/version header — hard to audit when they were last updated.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Create `00-core/INDEX.md` describing the purpose and recommended reading order for the 24 files |
| P2 | Add `> Version: X.Y \| Updated: YYYY-MM-DD` headers to each file |
| P2 | Explicitly link the three rules variants (1K/4K/10K) to each other and to the main `rules.md` |
| P3 | Verify consistency: confirm `rules.md` content is fully reflected in the 1K/4K condensed versions |

---

#### `docs/ai/01-context/project-context.md`

**Role:** Project-specific context — injected when building prompt packages for project-aware decisions.

**Recommendation:** P2 — Ensure this file is updated when new features or modules are added to the system.

---

#### `docs/ai/02-tasks/` — Task Prompts (24 files)

**Overview:** Each file corresponds to one `taskPrompt` in `routes.json`. These are the instruction sets for each task type.

| File | Route | Role |
|------|-------|------|
| `design.md` | design-screen, design-system | UI/UX design instructions |
| `code.md` | code-implement | Code implementation instructions |
| `architecture.md` | architecture | Architecture design instructions |
| `testing.md` | test-plan | Test writing instructions |
| `security.md` | security-audit | Security audit instructions |
| `performance.md` | performance-audit | Performance audit instructions |
| `ci-cd.md` | ci-cd | CI/CD instructions |
| `debug-triage.md` | debug-triage | Debug triage instructions |
| `research.md` | research | Research instructions |
| `ba.md` | ba | Business analyst instructions |
| `flutter-framework-decision.md` | flutter-framework-decision | Flutter framework API decision |
| `flutter-widget-decision.md` | widget-decision | Widget selection decision |
| `state-management-decision.md` | state-management-decision | State management decision |
| `package-selection.md` | package-selection | Package selection instructions |
| `custom-vs-package.md` | custom-vs-package | Custom vs. package decision |
| `pattern-selection.md` | pattern-selection | Design pattern selection |
| `code-organization.md` | code-organization | Code organization instructions |
| `module-design.md` | module-design | Module design instructions |
| `add-to-app.md` | add-to-app | Add-to-app integration |
| `plugin-authoring.md` | plugin-authoring | Plugin authoring instructions |
| `offline-sync.md` | offline-sync | Offline sync instructions |
| `web-desktop-strategy.md` | web-desktop-strategy | Web/desktop platform strategy |
| `agent-system.md` | agent-system | AI agent system design |
| `ai-evals.md` | ai-evals | AI eval design |
| `class-split-decision.md` | class-split-decision | Class split decision |
| `prompt-system.md` | prompt-system | Prompt system design |

**Overall quality:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Each file is focused on a single task type |
| Maintainability | ⚠️ No standard template for task prompt files → format may vary between files |
| Security | ✅ Text instructions; no risk |
| Standardization | ⚠️ Validated by `validate-manifest` (file existence only); internal format not checked |

**Strengths:** Complete task-type isolation — changing one task prompt does not affect others.

**Weaknesses:**
- No standard template for task prompt file structure.
- No automated check that task prompts contain required section headers.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Create a `task-prompt-template.md` with mandatory sections |
| P2 | Add a CI check verifying task prompts contain the required section headers |
| P2 | Add a date/version header to each file |

---

#### `docs/ai/03-memory/` — Memory Layer (6 files)

| File | Role |
|------|------|
| `decisions.md` | Log of architectural decisions made |
| `patterns.md` | Validated patterns in active use |
| `mistakes.md` | Past mistakes to avoid repeating |
| `modules.md` | Module knowledge base |
| `glossary.md` | System terminology glossary |
| `memory-governance.md` | Rules governing the memory layer |
| `incident-to-memory-loop.md` | Process: incident → memory update |

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Separated by memory type |
| Maintainability | ⚠️ Relies on the AI agent to self-update — no human review process defined |
| Security | ✅ Text content; no risk |
| Standardization | ⚠️ `memory-governance.md` defines rules but has no enforcement mechanism |

**Strengths:** `incident-to-memory-loop.md` is an enterprise-grade pattern rarely seen in AI tooling.

**Weaknesses:** No periodic memory pruning/audit to remove outdated entries.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Add a quarterly memory audit process to `memory-governance.md` |
| P2 | Add a `lastVerified` field to entries in `decisions.md` and `patterns.md` |

---

#### `docs/ai/04-templates/` — Output Templates (4 files)

| File | Role |
|------|------|
| `master-prompt-template.md` | Full prompt assembly template |
| `request-template.md` | Standard request template |
| `route-resolution-template.md` | Route resolution output template |
| `contract-shells.md` | Shell templates for each output contract |

**Strengths:** Template-driven approach ensures output consistency.

**Weaknesses:** No version in template file names → hard to migrate consumers when format changes.

**Recommendation:** P2 — Rename following `<template-name>-v<N>.md` convention to track versions.

---

#### `docs/ai/05-index/query-index.md`

**Role:** Fast-lookup index of query → route, supplementing `routes.json`.

**Recommendation:** P2 — Investigate whether this can be auto-generated from `routes.json` `queryPatterns` to keep it perpetually in sync.

---

#### `docs/ai/06-examples/route-examples.md`

**Role:** Concrete route resolution examples — helps new contributors understand routing behavior.

**Recommendation:** P2 — Add actual CLI JSON output alongside each example query.

---

#### `docs/ai/07-references/source-map.md`

**Role:** Maps documentation sources to routes/skills — used when the `IncludeReferences` flag is set.

**Recommendation:** P3 — Verify the source map is still accurate after every docs restructuring.

---

#### `docs/ai/08-guides/` — Flutter & AI Guides (~50 files)

**Overview:** Deep knowledge base split into:
- `flutter/` — 10 sections: app-architecture, data-and-backend, deployment, domains, packages-and-plugins, performance, platform-integration, security, testing-and-debugging, ui.
- `ai-systems/` — 6 files: agent-orchestration, context-memory-and-mcp, evals-and-regression, examples, prompt-optimization, index.
- `flutter-complete-rulebook.md` — Consolidated rulebook.
- `flutter-decision-handbook.md` — Decision handbook.
- `mobile-gap-analysis.md` — Mobile gap analysis.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear hierarchy: section → index → leaf docs |
| Maintainability | ⚠️ ~50 files requiring periodic review when Flutter APIs change |
| Security | ⚠️ `security/` section — must verify no outdated security advice |
| Standardization | ✅ Each section has `index.md` + `examples.md` |

**Strengths:**
- Comprehensive Flutter ecosystem coverage.
- Consistent pattern: index + examples per section.
- `mobile-gap-analysis.md` shows healthy self-awareness about missing coverage.

**Weaknesses:**
- No "last reviewed against Flutter version X.Y" metadata in any guide → silent staleness.
- The `security/` guides need more frequent review (security landscape changes quickly).

**Recommendations:**

| Priority | Action |
|----------|--------|
| P0 | Add Flutter version metadata to every section `index.md` |
| P1 | Schedule a quarterly review of the `security/` section |
| P1 | Create `08-guides/flutter/REVIEW-LOG.md` to track the last review date per section |
| P2 | Validate that no internal cross-links are broken after restructuring |

---

#### `docs/ai/09-roadmap/` — Roadmap (7 files)

| File | Role |
|------|------|
| `completion-master-plan.md` | Overall master plan |
| `pass-01.md` ~ `pass-05.md` | Per-iteration development passes |
| `task-backlog.md` | Pending task backlog |

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear iteration breakdown |
| Maintainability | ⚠️ Markdown roadmap is not synchronized with GitHub Issues |
| Security | ✅ No risk |
| Standardization | ⚠️ No explicit status field (done/in-progress/blocked) |

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Migrate `task-backlog.md` to GitHub Issues/Projects for better tracking |
| P2 | Add status indicators (✅/🔄/⛔) to each task in the pass files |

---

#### `docs/ai/10-releases/` — Releases (2 files)

| File | Role |
|------|------|
| `CHANGELOG.md` | Version change log |
| `release-baseline-template.md` | Release note template |

**Strengths:** CHANGELOG exists — good for traceability.

**Weaknesses:** No automated CHANGELOG generation from commit messages (e.g., Conventional Commits).

**Recommendation:** P2 — Adopt Conventional Commits and auto-generate CHANGELOG on release.

---

#### `docs/ai/11-skills/` — Skill Definitions (~35 files)

**Structure:**
```
11-skills/
├── README.md
├── skill-catalog.md       — L1/L2/L3 catalog
├── agents/                — 4 agent role files
├── commands/              — command-routing-map.md + README
├── hooks/                 — README only
├── plugins/               — plugin-schema.json + README
└── skills/                — 28 folders, one SKILL.md each
```

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ One-folder-per-skill — no duplication |
| Maintainability | ✅ `validate-manifest` checks SKILL.md existence |
| Security | ✅ |
| Standardization | ✅ Convention `skills/<id>/SKILL.md` is consistent |

**Strengths:** "No duplication" architecture is well-enforced via `validate-manifest`.

**Weaknesses:**
- `hooks/` and `plugins/` contain only READMEs — not implemented yet.
- `plugin-schema.json` is not validated in CI.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Add `plugin-schema.json` validation to `validate-manifest.ts` |
| P3 | Either implement the hooks system or explicitly mark it as "future" |

---

### Folder 4 summary

| Criterion | Score |
|-----------|-------|
| Structure | 5/5 |
| Maintainability | 3/5 |
| Security | 4/5 |
| Standardization | 3/5 |
| **Total** | **15/20** |

---

## Folder 5 — `missions/`

**Purpose:** Scoped task definitions — goal, constraints, route hint, success criteria, and optional eval cases. Bridges high-level intent with the routing/prompt system.

### File inventory

| # | File |
|---|------|
| 1 | `missions/README.md` |
| 2 | `missions/example-mission.yaml` |

---

### Per-file analysis

#### `missions/README.md`

**Role:** Short guide on how to use `missions/` — one file per mission, naming convention `<mission-id>.yaml`, links to canonical routing and example.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Concise and on-point |
| Maintainability | ✅ Pure guidance; no logic |
| Security | ✅ |
| Standardization | ⚠️ Required YAML schema fields are not explicitly defined |

**Strengths:** Short and focused — no bloat.

**Weaknesses:**
- No YAML Schema file for missions.
- Does not explain the mission lifecycle: how a mission is consumed by the CLI (only notes "canonical routing still lives in docs/ai").

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Create `missions/mission.schema.yaml` defining required and optional fields |
| P2 | Add a "How a mission flows into the CLI" section with an example command |
| P2 | Add a more realistic mission example (e.g., offline-sync module) |

---

#### `missions/example-mission.yaml`

**Role:** Single example mission — `goal: "Design and review a Flutter login screen with Material 3"`, route hint `design-screen`, constraints, `definition_of_done`, `optional_eval_cases`.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clean YAML; sensible fields |
| Maintainability | ✅ Easy to copy-paste to create new missions |
| Security | ✅ |
| Standardization | ⚠️ Not validated by any tool |

**Strengths:** `definition_of_done` field provides clear acceptance criteria.

**Weaknesses:**
- `primary_route_hint: design-screen` is not validated against `routes.json`.
- `optional_eval_cases` references an eval file but its existence is not checked.
- Missing fields: `priority`, `assignee`, `status`, `created_at`.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Validate `primary_route_hint` exists in `routes.json` when a mission is parsed |
| P1 | Validate that `optional_eval_cases` paths exist |
| P2 | Add `status: draft\|active\|completed` and `created_at` fields |
| P3 | Add 2–3 more example missions covering other route types (code, architecture, security) |

---

### Folder 5 summary

| Criterion | Score |
|-----------|-------|
| Structure | 4/5 |
| Maintainability | 3/5 |
| Security | 5/5 |
| Standardization | 2/5 |
| **Total** | **14/20** |

---

## Folder 6 — `playground/`

**Purpose:** Experimental environment — experiments, demos, scratch prompts. Not a release artifact.

### File inventory

| # | File |
|---|------|
| 1 | `playground/README.md` |
| 2 | `playground/showcase-route-resolve.md` |

---

### Per-file analysis

#### `playground/README.md`

**Role:** Defines the playground's purpose and suggested use cases — try new `queryPatterns`, draft mission YAML, keep showcases small.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Short and clearly scoped |
| Maintainability | ✅ Stable guidance; rarely needs updating |
| Security | ✅ Explicitly states "not a release artifact" |
| Standardization | ⚠️ No template or format defined for playground files |

**Strengths:** Clear boundary: "Playground ≠ production" — reduces risk of accidentally merging experimental code.

**Weaknesses:**
- No link to the "graduate to missions/" process when a showcase becomes stable.
- "Small" is not defined (no line/section limit).

**Recommendations:**

| Priority | Action |
|----------|--------|
| P2 | Add a "Graduate to missions/" process: "Once a showcase is stable, create a mission YAML and link here" |
| P3 | Define a naming convention for playground files (e.g., `experiment-<topic>-YYYY-MM.md`) |

---

#### `playground/showcase-route-resolve.md`

**Role:** End-to-end workflow demo: `resolve` query → `build` prompt package → TypeScript runtime with `--command plan`.

**Quality assessment:**

| Criterion | Rating |
|-----------|--------|
| Structure | ✅ Clear step-by-step |
| Maintainability | ⚠️ Commands use relative paths — easy to break after restructuring |
| Security | ✅ No secrets or sensitive information |
| Standardization | ⚠️ No expected output shown — users cannot verify they got the right result |

**Strengths:** Covers all three execution paths (PowerShell, PowerShell with flags, TypeScript) in one file.

**Weaknesses:**
- No sample expected output per command.
- No "Prerequisites" section (which Node.js version, which pwsh version is needed).
- TypeScript command does not demonstrate the `--explain` flag — a useful but undiscoverable feature.

**Recommendations:**

| Priority | Action |
|----------|--------|
| P1 | Add sample expected JSON output after each command |
| P1 | Add a "Prerequisites" section with version requirements |
| P2 | Add Step 4: TypeScript with `--explain` flag to showcase top route candidates |
| P3 | Add Step 5: `validate-manifest` run to close the workflow loop |

---

### Folder 6 summary

| Criterion | Score |
|-----------|-------|
| Structure | 4/5 |
| Maintainability | 3/5 |
| Security | 5/5 |
| Standardization | 2/5 |
| **Total** | **14/20** |

---

## Overall Audit Summary

### Score table

| Folder | Structure | Maintainability | Security | Standardization | Total |
|--------|-----------|-----------------|----------|-----------------|-------|
| Folder 2: `agent/` | 4/5 | 3/5 | 5/5 | 3/5 | **15/20** |
| Folder 3: `tools/` | 5/5 | 3/5 | 5/5 | 4/5 | **17/20** |
| Folder 4: `docs/` | 5/5 | 3/5 | 4/5 | 3/5 | **15/20** |
| Folder 5: `missions/` | 4/5 | 3/5 | 5/5 | 2/5 | **14/20** |
| Folder 6: `playground/` | 4/5 | 3/5 | 5/5 | 2/5 | **14/20** |
| **Total** | **22/25** | **15/25** | **24/25** | **14/25** | **75/100** |

---

### Top priority actions (P0/P1)

| Priority | Action | Folder |
|----------|--------|--------|
| **P0** | Add Flutter version metadata to every `docs/ai/08-guides/flutter/` section `index.md` | `docs/` |
| **P1** | Create `routes.schema.json` for IDE-level validation of `routes.json` | `tools/` |
| **P1** | Add a short-description column to `agent/SKILLS.md` | `agent/` |
| **P1** | Extend `validate-manifest` to check `flutter-domains.json` `files[]` and `SKILLS.md` sync | `tools/` |
| **P1** | Create `missions/mission.schema.yaml` and validate `primary_route_hint` in the CLI | `missions/` |
| **P1** | Add sample expected output to `playground/showcase-route-resolve.md` | `playground/` |
| **P1** | Add tests for `commands.ts`, `normalize.ts`, and `validate-manifest` parsing functions | `tools/` |
| **P1** | Create `docs/ai/00-core/INDEX.md` | `docs/` |
| **P1** | Populate `manualQualityAverage` after the first rubric scoring cycle | `tools/` |
| **P1** | Add Pester tests for `aiprompt.ps1` scoring functions | `tools/` |

---

### Overall assessment

**System strengths:**
1. **"No-duplication" architecture** enforced effectively via `validate-manifest`.
2. **High security posture** — no secrets, no dynamic execution, no runtime dependencies.
3. **Explicit parity** between the PowerShell and TypeScript routers.
4. **Comprehensive eval tooling**: eval gates, quality rubric, telemetry schema, trend baseline.

**System weaknesses to prioritize:**
1. **Low test coverage**: `aiprompt.ps1` has no Pester tests; `commands.ts` and `normalize.ts` have no unit tests.
2. **Uneven standardization**: `missions/` and `playground/` lack schema validation.
3. **Documentation maintainability**: no version/date headers — hard to audit when files were last updated.
4. **Routing quality never measured in practice** (`manualQualityAverage: null`).

---

*Report generated by Copilot Coding Agent — 2026-04-08*

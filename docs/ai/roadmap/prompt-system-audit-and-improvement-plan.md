# Prompt System Audit and Improvement Plan

This document audits the current Dart/Flutter prompt operating system against organizational structure, content, folder layout, and AI-skill capabilities. It maps specialist topics (skills, MCP, validation, hooks, Flutter, testing, BA, and so on) to existing artifacts and proposes improvements. It complements `execution-master-plan.md` and the five pass files (`foundation-and-ai-coverage.md` through `production-hardening-and-baseline.md`).

---

## 1. Scope and method

**In scope:** `docs/ai/` (especially `core/`, `context/`, `tasks/`, `memory/`, `templates/`, `indexes/`, `guides/`, `roadmap/`, `skill-system/`), `agent/`, `tools/prompt-powershell/`, `tools/prompt-runtime-typescript/`, `.promptos/`, `missions/`.

**Method:** Document inventory, policy review (`folder-standards.md`, `context-loading-rules.md`, `memory-governance.md`, `mcp-research-policy.md`, `output-rules.md`, `answer-policies.md`, `skill-registry.md`), and gap analysis against desired runtime behavior (routing, contracts, memory, research, security).

---

## 2. Organizational structure and folders

### 2.1 Strengths

- **Single responsibility per folder** is explicit in `core/system/folder-standards.md`: core rules vs tasks vs memory vs guides vs skills.
- **Layered loading** (`core/policies/context-loading-rules.md`) reduces token waste: always-load core, load one task, optional guides and domain packs.
- **Stable vs volatile split:** `context/` for slow-changing project facts; `memory/` for durable decisions, patterns, mistakes, glossary, modules.
- **Operational tooling:** `tools/prompt-powershell/` (routes, evals), `tools/prompt-runtime-typescript/` (router, manifest validation) support deterministic routing regression.
- **Roadmap program:** `roadmap/execution-master-plan.md` defines five passes and completion criteria.

### 2.2 Gaps

- **Enforcement gap:** Markdown policies are strong; not every change path is gated by CI (depends on repo setup). Risk of drift between `routes.json`, task prompts, and contracts.
- **Index vs body:** Guides under `guides/flutter/` are extensive but may lag `flutter.dev`; `guides/flutter/mobile-gap-analysis.md` tracks known gaps.
- **`.promptos/` usage:** Valuable for plans/runs/metrics if adopted consistently; otherwise observability is documentation-only.

---

## 3. Content assessment

### 3.1 Core content (`core/`)

| Artifact | Role | Assessment |
| --- | --- | --- |
| `system-prompt.md`, `decision-engine.md`, `self-analysis-protocol.md` | Behavior and reasoning | Foundational. |
| `output-rules.md`, `output-contracts.md`, `answer-policies.md`, `response-depth-policy.md` | Output shape and depth | Strong; ties answers to route family. |
| `token-rules.md` | Cost control | Aligns with layered context. |
| `skill-registry.md`, `skill-precedence-policy.md` | Skill activation | Clear precedence rules. |
| `mcp-research-policy.md` | Research ordering | Official sources prioritized. |
| `prompt-versioning-policy.md`, `prompt-release-checklist.md` | Lifecycle | Supports controlled changes. |

### 3.2 Memory (`memory/`)

- **Governance** (`memory-governance.md`): Approval, deduplication, pruning, promotionÃ¢â‚¬â€well specified.
- **Incident loop** (`incident-to-memory-loop.md`): Links incidents to memory files and eval cases.
- **Gap:** Synthesis of Ã¢â‚¬Å“resolved issuesÃ¢â‚¬Â into durable MD is **process-defined** but not **tool-automated** (no required template file per incident beyond the loopÃ¢â‚¬â„¢s fields).

### 3.3 Guides and skills (`guides/`, `skill-system/`)

- Flutter domains, security, deployment, performance, testing, AI/MCP guides exist as retrieval packs.
- `skill-system/` contains `SKILL.md` files per logical skill, hooks, plugins schema, agents, commandsÃ¢â‚¬â€**coverage is broad; depth per skill varies**.

---

## 4. Capability matrix (AI techniques)

This maps desired capabilities to what the repo already encodes and what to improve.

| Capability | Current support | Improvement actions |
| --- | --- | --- |
| **Clear input** | Task prompts in `tasks/`; hook concept `pre-route` (`skill-system/hooks/README.md`) | Add per-route **input checklist** (required fields, forbidden ambiguity) in task files or `templates/`; align with CLI route metadata if present. |
| **Memory (durable facts)** | `decisions.md`, `patterns.md`, `mistakes.md`, `glossary.md`, `modules.md` + governance | Optional script to flag duplicate headings; monthly review checklist in `memory/` README. |
| **Context loading** | `context-loading-rules.md` | Document **anti-patterns** (loading all indexes, skipping `guides/flutter/index.md`). |
| **Recall / long-session coherence** | Memory files + curator skill | Distinguish **episodic** (run logs in `.promptos/`) vs **semantic** (memory files) in one short `memory/` note. |
| **Synthesis: resolved issues Ã¢â€ â€™ MD** | `incident-to-memory-loop.md` | Add canonical template `templates/resolved-issue-memory.md` with fields: id, date, route, root cause, fix, prevention, memory file, eval id. |
| **Research** | `mcp-research-policy.md`, `source-validator` skill | Enforce **version/date** for API-sensitive answers in task prompts; expand eval cases for stale API usage. |
| **Analysis** | `decision-engine.md`, decision-matrix contracts | Golden evals for bad trade-offs; keep `self-analysis-protocol.md` linked from high-risk tasks. |
| **Routing** | `routes.json`, TS router, CLI | Mandatory regression when routes change; document parity rules in `tools/prompt-runtime-typescript/`. |
| **Extensibility** | `folder-standards.md`, plugins `plugin-schema.json` | Single Ã¢â‚¬Å“how to add a routeÃ¢â‚¬Â page in `getting-started.md` or `templates/`. |
| **Connectivity (MCP, tools)** | `mcp-orchestrator`, MCP guides | Document fallback when MCP unavailable (local grep, read-only assumptions). |
| **Clear output** | `output-rules.md`, contracts | CI or checklist: task Ã¢â€ â€™ contract id mapping for top routes. |
| **Security** | Security guides, `security-auditor`, review family | Centralize **secret/redaction** rules in `core/` if not already consolidated; link from `tasks/security`-related prompts. |
| **Scope** | Token rules, depth policy | Explicit **out of scope** bullets in ambiguous routes (legal, medical, deployment without credentials). |
| **Choice / correctness** | Decision-matrix contract | Eval cases for Ã¢â‚¬Å“wrong defaultÃ¢â‚¬Â patterns per route family. |
| **Judgment (right/wrong)** | Review reports, severity ordering | Calibrate with `quality-grader` and human spot checks; avoid overconfidence in single-turn answersÃ¢â‚¬â€state uncertainty. |
| **Data filtering** | Ã¢â‚¬Å“Relevant memory onlyÃ¢â‚¬Â, summarization | Add **retrieval protocol** snippet to relevant tasks: query Ã¢â€ â€™ index Ã¢â€ â€™ section Ã¢â€ â€™ `examples.md` Ã¢â€ â€™ leaf pack. |

---

## 5. Skill-topic mapping

The table below maps topics you listed to **`skill_id`** entries in `core/contracts/skill-registry.md` and/or primary doc locations. Items without a dedicated `SKILL.md` may still be covered by guides or task prompts.

| Topic | Registry / location | Notes |
| --- | --- | --- |
| Skill config / precedence | `skill-registry.md`, `skill-precedence-policy.md` | Activation rules are explicit. |
| Skill schema | `skill-system/plugins/plugin-schema.json`, hooks | Plugins require `id`, `version`, `description`, `hookPoints`. |
| Skill examples | `skill-system/definitions/*/SKILL.md`, `guides/.../examples.md` | Expand minimal examples where stubs remain. |
| MCP server | `mcp-orchestrator`, `guides/flutter/ai/`, `core/policies/mcp-research-policy.md` | Host-dependent; document discovery and auth. |
| Automation | Hooks (`pre-route` Ã¢â‚¬Â¦ `pre-release-gate`), `.promptos/` | Define what runs in CI vs manual. |
| Validate | `tools/prompt-runtime-typescript` validate-manifest, eval packs | Extend coverage for manifest and route JSON. |
| Hook | `skill-system/hooks/README.md` | Reference validators per hook if tooling allows. |
| Agent | `agent-architect`, `skill-system/agents/*.md`, `tasks/ai-systems/agent-system.md` | Multi-agent rules in registry. |
| Flutter | `framework-advisor`, `flutter-*` skills, `guides/flutter/` | Main domain; prioritize guide completeness. |
| Template | `templates/` | Route resolution template exists. |
| Widgets | `widget-selector`, `guides/flutter/ui/` | Widget-by-widget examples available. |
| Storage | `security-auditor`, patterns/memory, security guides | Local storage and secretsÃ¢â‚¬â€tie to platform guides. |
| Security | `security-auditor`, `guides/flutter/security/` | Network, WebView, file upload, release hardening. |
| Design pattern | `pattern-advisor`, architecture guides | Clean arch and patterns in app-architecture guides. |
| Clean architecture | `flutter-architect`, `module-designer`, `guides/flutter/app-architecture/` | Feature model organization documented. |
| Long memory | `memory-curator`, `memory/` | Governance + incident loop; optional episodic note. |
| Performance | `performance-analyst`, `guides/flutter/performance/` | Startup, lists, images, memory. |
| Dart | Implicit in `flutter-coder`, framework guides | Could add explicit `dart-style` pointer in registry if needed. |
| Mobile | `guides/flutter/mobile-gap-analysis.md`, platform integration | Gap analysis drives backlog. |
| Deploy mobile app | `release-manager`, `guides/flutter/deployment/` | Flavors, signing, secrets. |
| Test case | `test-engineer`, `guides/flutter/testing-and-debugging/` | Widget, golden, integration scope selection. |
| BA (business analysis) | `business-analyst` | Acceptance criteria and scope refinement. |

---

## 6. Risks

1. **Policy without enforcement:** Hosts may ignore layering unless packaged or checked.
2. **Stale memory** contradicting repository reality.
3. **Incomplete guides** leading to incorrect API or version advice.
4. **Secrets** in logs, memory, or pasted codeÃ¢â‚¬â€needs redaction discipline.
5. **Routing regressions** if CLI/TS tests are not run after manifest edits.

---

## 7. Improvement plan (phased)

Aligned with `execution-master-plan.md` (foundation through production hardening). Below are **additional** concrete actions tied to this audit.

### Phase A Ã¢â‚¬â€ Foundation

- A1: **Route Ã¢â€ â€ contract matrix:** Ensure each high-traffic `tasks/*.md` names one primary `output-contracts.md` id.
- A2: **CI / PR gate:** Run manifest validation and route regression when `routes.json`, manifests, or `core/` contract files change.
- A3: **Resolved-issue template:** Done Ã¢â‚¬â€ `templates/resolved-issue-memory.md` (empty + filled example); linked from `incident-to-memory-loop.md`.

### Phase B Ã¢â‚¬â€ Memory and synthesis

- B1: **Memory README:** Done Ã¢â‚¬â€ `memory/README.md` (file index, governance pointers, maintenance checklist).
- B2: **Promotion discipline:** Only promote after validation signal (per `memory-governance.md`); link eval id when updating `mistakes.md`.

### Phase C Ã¢â‚¬â€ Research and filtering

- C1: **Retrieval protocol:** Add optional block to Flutter tasks: index Ã¢â€ â€™ section Ã¢â€ â€™ examples Ã¢â€ â€™ domain leaf.
- C2: **Eval expansion:** Stale API, wrong package version, deprecated pattern.

### Phase D Ã¢â‚¬â€ Skills and integrations

- D1: **SKILL.md quality bar:** Applied across `docs/ai/skill-system/definitions/*/SKILL.md`: each file includes **Example** (code or structured artifact where appropriate) and **Anti-patterns**; core and specialist skills updated in repo sweep.
- D2: **Authoring + pipeline docs:** `docs/ai/skill-system/skill-authoring-guide.md` (context, constraints, steps, progressive disclosure, checklist; external references to Agent Skills / Anthropic practices); `docs/ai/skill-system/skill-execution-pipeline.md` (hook + skill order); expanded `skill-catalog.md`, `skill-system/README.md`, `hooks/README.md`, `plugins/README.md`.
- D3: **MCP runbook:** Connection, auth, fallback behavior in `guides/mcp/context-memory-and-connectors.md` or adjacent.

### Phase E Ã¢â‚¬â€ Security and scope (continuous)

- E1: Redaction rules in `core/` and pointer from security-related tasks.
- E2: Explicit out-of-scope lines for sensitive domains.

---

## 8. Success metrics

| Metric | Target |
| --- | --- |
| Manifest validation + route tests on main | Passing |
| New memory entries with owner, date, impact | 100% |
| Top routes with explicit contract id | Ã¢â€°Â¥ 90% |
| Flutter API answers traceable to guide path (spot audits) | High |

---

## 9. Conclusion

The repository already implements a **coherent prompt operating system**: folder standards, layered context, governed memory, routing tooling, output contracts, research policy, and a broad skill registry with Flutter-oriented guides. The main improvements are **enforcement** (CI, checklists), **structured synthesis** of resolved issues into memory-ready MD, **research and retrieval discipline**, **SKILL.md depth**, and **continued guide completeness** (per mobile gap analysis and official docs alignment). Executing this plan alongside the five-pass completion program yields a more reliable, auditable, and maintainable system.

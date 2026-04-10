# Prompt System Audit and Improvement Plan

This document audits the current Dart/Flutter prompt operating system against organizational structure, content, folder layout, and AI-skill capabilities. It maps specialist topics (skills, MCP, validation, hooks, Flutter, testing, BA, and so on) to existing artifacts and proposes improvements. It complements `completion-master-plan.md` and the five pass files (`pass-01.md` … `pass-05.md`).

---

## 1. Scope and method

**In scope:** `docs/ai/` (especially `00-core/`, `01-context/`, `02-tasks/`, `03-memory/`, `04-templates/`, `05-index/`, `08-guides/`, `09-roadmap/`, `11-skills/`), `agent/`, `tools/prompt-cli/`, `tools/prompt-runtime-ts/`, `.promptos/`, `missions/`.

**Method:** Document inventory, policy review (`folder-standards.md`, `context-loading-rules.md`, `memory-governance.md`, `mcp-research-policy.md`, `output-rules.md`, `answer-policies.md`, `skill-registry.md`), and gap analysis against desired runtime behavior (routing, contracts, memory, research, security).

---

## 2. Organizational structure and folders

### 2.1 Strengths

- **Single responsibility per folder** is explicit in `00-core/system/folder-standards.md`: core rules vs tasks vs memory vs guides vs skills.
- **Layered loading** (`00-core/policies/context-loading-rules.md`) reduces token waste: always-load core, load one task, optional guides and domain packs.
- **Stable vs volatile split:** `01-context/` for slow-changing project facts; `03-memory/` for durable decisions, patterns, mistakes, glossary, modules.
- **Operational tooling:** `tools/prompt-cli/` (routes, evals), `tools/prompt-runtime-ts/` (router, manifest validation) support deterministic routing regression.
- **Roadmap program:** `09-roadmap/completion-master-plan.md` defines five passes and completion criteria.

### 2.2 Gaps

- **Enforcement gap:** Markdown policies are strong; not every change path is gated by CI (depends on repo setup). Risk of drift between `routes.json`, task prompts, and contracts.
- **Index vs body:** Guides under `08-guides/flutter/` are extensive but may lag `flutter.dev`; `08-guides/flutter/mobile-gap-analysis.md` tracks known gaps.
- **`.promptos/` usage:** Valuable for plans/runs/metrics if adopted consistently; otherwise observability is documentation-only.

---

## 3. Content assessment

### 3.1 Core content (`00-core/`)

| Artifact | Role | Assessment |
| --- | --- | --- |
| `system-prompt.md`, `decision-engine.md`, `self-analysis-protocol.md` | Behavior and reasoning | Foundational. |
| `output-rules.md`, `output-contracts.md`, `answer-policies.md`, `response-depth-policy.md` | Output shape and depth | Strong; ties answers to route family. |
| `token-rules.md` | Cost control | Aligns with layered context. |
| `skill-registry.md`, `skill-precedence-policy.md` | Skill activation | Clear precedence rules. |
| `mcp-research-policy.md` | Research ordering | Official sources prioritized. |
| `prompt-versioning-policy.md`, `prompt-release-checklist.md` | Lifecycle | Supports controlled changes. |

### 3.2 Memory (`03-memory/`)

- **Governance** (`memory-governance.md`): Approval, deduplication, pruning, promotion—well specified.
- **Incident loop** (`incident-to-memory-loop.md`): Links incidents to memory files and eval cases.
- **Gap:** Synthesis of “resolved issues” into durable MD is **process-defined** but not **tool-automated** (no required template file per incident beyond the loop’s fields).

### 3.3 Guides and skills (`08-guides/`, `11-skills/`)

- Flutter domains, security, deployment, performance, testing, AI/MCP guides exist as retrieval packs.
- `11-skills/` contains `SKILL.md` files per logical skill, hooks, plugins schema, agents, commands—**coverage is broad; depth per skill varies**.

---

## 4. Capability matrix (AI techniques)

This maps desired capabilities to what the repo already encodes and what to improve.

| Capability | Current support | Improvement actions |
| --- | --- | --- |
| **Clear input** | Task prompts in `02-tasks/`; hook concept `pre-route` (`11-skills/hooks/README.md`) | Add per-route **input checklist** (required fields, forbidden ambiguity) in task files or `04-templates/`; align with CLI route metadata if present. |
| **Memory (durable facts)** | `decisions.md`, `patterns.md`, `mistakes.md`, `glossary.md`, `modules.md` + governance | Optional script to flag duplicate headings; monthly review checklist in `03-memory/` README. |
| **Context loading** | `context-loading-rules.md` | Document **anti-patterns** (loading all indexes, skipping `08-guides/flutter/index.md`). |
| **Recall / long-session coherence** | Memory files + curator skill | Distinguish **episodic** (run logs in `.promptos/`) vs **semantic** (memory files) in one short `03-memory/` note. |
| **Synthesis: resolved issues → MD** | `incident-to-memory-loop.md` | Add canonical template `04-templates/resolved-issue-memory.md` with fields: id, date, route, root cause, fix, prevention, memory file, eval id. |
| **Research** | `mcp-research-policy.md`, `source-validator` skill | Enforce **version/date** for API-sensitive answers in task prompts; expand eval cases for stale API usage. |
| **Analysis** | `decision-engine.md`, decision-matrix contracts | Golden evals for bad trade-offs; keep `self-analysis-protocol.md` linked from high-risk tasks. |
| **Routing** | `routes.json`, TS router, CLI | Mandatory regression when routes change; document parity rules in `tools/prompt-runtime-ts/`. |
| **Extensibility** | `folder-standards.md`, plugins `plugin-schema.json` | Single “how to add a route” page in `GETTING_STARTED.md` or `04-templates/`. |
| **Connectivity (MCP, tools)** | `mcp-orchestrator`, MCP guides | Document fallback when MCP unavailable (local grep, read-only assumptions). |
| **Clear output** | `output-rules.md`, contracts | CI or checklist: task → contract id mapping for top routes. |
| **Security** | Security guides, `security-auditor`, review family | Centralize **secret/redaction** rules in `00-core/` if not already consolidated; link from `02-tasks/security`-related prompts. |
| **Scope** | Token rules, depth policy | Explicit **out of scope** bullets in ambiguous routes (legal, medical, deployment without credentials). |
| **Choice / correctness** | Decision-matrix contract | Eval cases for “wrong default” patterns per route family. |
| **Judgment (right/wrong)** | Review reports, severity ordering | Calibrate with `quality-grader` and human spot checks; avoid overconfidence in single-turn answers—state uncertainty. |
| **Data filtering** | “Relevant memory only”, summarization | Add **retrieval protocol** snippet to relevant tasks: query → index → section → `examples.md` → leaf pack. |

---

## 5. Skill-topic mapping

The table below maps topics you listed to **`skill_id`** entries in `00-core/contracts/skill-registry.md` and/or primary doc locations. Items without a dedicated `SKILL.md` may still be covered by guides or task prompts.

| Topic | Registry / location | Notes |
| --- | --- | --- |
| Skill config / precedence | `skill-registry.md`, `skill-precedence-policy.md` | Activation rules are explicit. |
| Skill schema | `11-skills/plugins/plugin-schema.json`, hooks | Plugins require `id`, `version`, `description`, `hookPoints`. |
| Skill examples | `11-skills/skills/*/SKILL.md`, `08-guides/.../examples.md` | Expand minimal examples where stubs remain. |
| MCP server | `mcp-orchestrator`, `08-guides/flutter/ai-and-mcp/`, `00-core/policies/mcp-research-policy.md` | Host-dependent; document discovery and auth. |
| Automation | Hooks (`pre-route` … `pre-release-gate`), `.promptos/` | Define what runs in CI vs manual. |
| Validate | `tools/prompt-runtime-ts` validate-manifest, eval packs | Extend coverage for manifest and route JSON. |
| Hook | `11-skills/hooks/README.md` | Reference validators per hook if tooling allows. |
| Agent | `agent-architect`, `11-skills/agents/*.md`, `02-tasks/ai/agent-system.md` | Multi-agent rules in registry. |
| Flutter | `framework-advisor`, `flutter-*` skills, `08-guides/flutter/` | Main domain; prioritize guide completeness. |
| Template | `04-templates/` | Route resolution template exists. |
| Widgets | `widget-selector`, `08-guides/flutter/ui/` | Widget-by-widget examples available. |
| Storage | `security-auditor`, patterns/memory, security guides | Local storage and secrets—tie to platform guides. |
| Security | `security-auditor`, `08-guides/flutter/security/` | Network, WebView, file upload, release hardening. |
| Design pattern | `pattern-advisor`, architecture guides | Clean arch and patterns in app-architecture guides. |
| Clean architecture | `flutter-architect`, `module-designer`, `08-guides/flutter/app-architecture/` | Feature model organization documented. |
| Long memory | `memory-curator`, `03-memory/` | Governance + incident loop; optional episodic note. |
| Performance | `performance-analyst`, `08-guides/flutter/performance/` | Startup, lists, images, memory. |
| Dart | Implicit in `flutter-coder`, framework guides | Could add explicit `dart-style` pointer in registry if needed. |
| Mobile | `08-guides/flutter/mobile-gap-analysis.md`, platform integration | Gap analysis drives backlog. |
| Deploy mobile app | `release-manager`, `08-guides/flutter/deployment/` | Flavors, signing, secrets. |
| Test case | `test-engineer`, `08-guides/flutter/testing-and-debugging/` | Widget, golden, integration scope selection. |
| BA (business analysis) | `business-analyst` | Acceptance criteria and scope refinement. |

---

## 6. Risks

1. **Policy without enforcement:** Hosts may ignore layering unless packaged or checked.
2. **Stale memory** contradicting repository reality.
3. **Incomplete guides** leading to incorrect API or version advice.
4. **Secrets** in logs, memory, or pasted code—needs redaction discipline.
5. **Routing regressions** if CLI/TS tests are not run after manifest edits.

---

## 7. Improvement plan (phased)

Aligned with `completion-master-plan.md` (Passes 01–05). Below are **additional** concrete actions tied to this audit.

### Phase A — Foundation

- A1: **Route ↔ contract matrix:** Ensure each high-traffic `02-tasks/*.md` names one primary `output-contracts.md` id.
- A2: **CI / PR gate:** Run manifest validation and route regression when `routes.json`, manifests, or `00-core/` contract files change.
- A3: **Resolved-issue template:** Done — `04-templates/resolved-issue-memory.md` (empty + filled example); linked from `incident-to-memory-loop.md`.

### Phase B — Memory and synthesis

- B1: **Memory README:** Done — `03-memory/README.md` (file index, governance pointers, maintenance checklist).
- B2: **Promotion discipline:** Only promote after validation signal (per `memory-governance.md`); link eval id when updating `mistakes.md`.

### Phase C — Research and filtering

- C1: **Retrieval protocol:** Add optional block to Flutter tasks: index → section → examples → domain leaf.
- C2: **Eval expansion:** Stale API, wrong package version, deprecated pattern.

### Phase D — Skills and integrations

- D1: **SKILL.md quality bar:** Applied across `docs/ai/11-skills/skills/*/SKILL.md`: each file includes **Example** (code or structured artifact where appropriate) and **Anti-patterns**; core and specialist skills updated in repo sweep.
- D2: **Authoring + pipeline docs:** `docs/ai/11-skills/SKILL-AUTHORING.md` (context, constraints, steps, progressive disclosure, checklist; external references to Agent Skills / Anthropic practices); `docs/ai/11-skills/skill-execution-pipeline.md` (hook + skill order); expanded `skill-catalog.md`, `11-skills/README.md`, `hooks/README.md`, `plugins/README.md`.
- D3: **MCP runbook:** Connection, auth, fallback behavior in `08-guides/ai-systems/context-memory-and-mcp.md` or adjacent.

### Phase E — Security and scope (continuous)

- E1: Redaction rules in `00-core/` and pointer from security-related tasks.
- E2: Explicit out-of-scope lines for sensitive domains.

---

## 8. Success metrics

| Metric | Target |
| --- | --- |
| Manifest validation + route tests on main | Passing |
| New memory entries with owner, date, impact | 100% |
| Top routes with explicit contract id | ≥ 90% |
| Flutter API answers traceable to guide path (spot audits) | High |

---

## 9. Conclusion

The repository already implements a **coherent prompt operating system**: folder standards, layered context, governed memory, routing tooling, output contracts, research policy, and a broad skill registry with Flutter-oriented guides. The main improvements are **enforcement** (CI, checklists), **structured synthesis** of resolved issues into memory-ready MD, **research and retrieval discipline**, **SKILL.md depth**, and **continued guide completeness** (per mobile gap analysis and official docs alignment). Executing this plan alongside the five-pass completion program yields a more reliable, auditable, and maintainable system.

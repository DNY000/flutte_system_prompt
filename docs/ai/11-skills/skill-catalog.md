# Skill Catalog

Operational catalog for onboarding and maintaining AI skills.

**Flat index (all SKILL.md paths):** `agent/SKILLS.md`

**Authoring (context + constraints + steps):** `SKILL-AUTHORING.md`  
**End-to-end pipeline (hooks, loader, verification):** `skill-execution-pipeline.md`  
**Registry and activation rules:** `../00-core/skill-registry.md`, `../00-core/skill-precedence-policy.md`, `../00-core/skill-contracts.md`

## Full context stack (what must be “enough”)

| Layer | Location | Purpose |
| --- | --- | --- |
| Routing | `../00-core/routing-rules.md`, `tools/prompt-cli/routes.json` | One `route_id`, contract id, risk |
| Task behavior | `../02-tasks/<route>.md` | Required inputs, forbidden loads, answer shape |
| Project facts | `../01-context/project-context.md` | SDK bounds, flavors, team conventions |
| Skills | `skills/<skill_id>/SKILL.md` | Ordered steps, examples, anti-patterns |
| Retrieval | `../08-guides/flutter/index.md` + one leaf | Version-sensitive API detail |
| Memory | `../03-memory/*.md` | Durable decisions only when relevant |

**Global constraints:** `../00-core/output-rules.md`, `../00-core/token-rules.md`, `../00-core/mcp-research-policy.md`, `../00-core/answer-policies.md`.

## End-to-end steps (summary)

1. **Normalize** request → `pre-route` hook.  
2. **Route** → `intent-router` → `post-route` hook.  
3. **Resolve skills** → `routes.json` + precedence policy.  
4. **Load context** → `context-loader` per `context-loading-rules.md`.  
5. **Execute** → specialist `SKILL.md` steps; add `source-validator` / `mcp-orchestrator` when needed.  
6. **Verify** → tests, rubric, `post-execute` hook.  
7. **Persist** → `memory-curator` + `04-templates/resolved-issue-memory.md` when durable.  

Detail: `skill-execution-pipeline.md`.

## Levels

- L1: baseline skill, can handle narrow tasks with explicit context
- L2: production skill, handles ambiguous inputs with guardrails
- L3: lead skill, can supervise multi-skill workflows and trade-offs

## Skill Groups

- routing and context: `intent-router`, `context-loader`
- architecture and design: `flutter-architect`, `module-designer`, `hybrid-integrator`, `multiplatform-strategist`, `plugin-engineer`, `sync-architect`
- implementation and quality: `flutter-coder`, `test-engineer`, `security-auditor`, `performance-analyst`, `debug-investigator`
- release and governance: `ci-engineer`, `release-manager`, `quality-grader`, `observability-engineer`
- research and systems: `research-analyst`, `source-validator`, `prompt-architect`, `agent-architect`, `eval-designer`, `mcp-orchestrator`

## Minimum Production Set

- must-have skills for stable runtime:
  - `intent-router`
  - `context-loader`
  - `flutter-coder`
  - `flutter-architect`
  - `test-engineer`
  - `security-auditor`
  - `performance-analyst`
  - `quality-grader`
  - `release-manager`

## Promotion Criteria

- L1 -> L2:
  - used in at least 20 routed tasks
  - no critical process gaps in reviews
- L2 -> L3:
  - successful multi-skill orchestration
  - stable outcomes under high-risk requests

## Optional / draft skills

Rare or team-only skills can live as drafts under `skills/<skill-id>/` (for example on a branch) until you promote them through `docs/ai/00-core/skill-registry.md`, `tools/prompt-cli/routes.json`, and eval updates.

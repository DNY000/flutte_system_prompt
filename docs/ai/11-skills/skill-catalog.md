# Skill Catalog

Operational catalog for onboarding and maintaining AI skills.

**Flat index (all SKILL.md paths):** `agent/SKILLS.md`

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

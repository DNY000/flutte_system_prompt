# Agent — skill index (Flutter / mobile prompt OS)

**Single navigation page** for all logical skills. Executable definitions live under `docs/ai/11-skills/skills/<skill_id>/SKILL.md`. Registry and activation rules: `docs/ai/00-core/skill-registry.md`.

## Core skills

| skill_id | SKILL.md |
| --- | --- |
| `intent-router` | `docs/ai/11-skills/skills/intent-router/SKILL.md` |
| `context-loader` | `docs/ai/11-skills/skills/context-loader/SKILL.md` |
| `memory-curator` | `docs/ai/11-skills/skills/memory-curator/SKILL.md` |
| `mcp-orchestrator` | `docs/ai/11-skills/skills/mcp-orchestrator/SKILL.md` |
| `quality-grader` | `docs/ai/11-skills/skills/quality-grader/SKILL.md` |
| `source-validator` | `docs/ai/11-skills/skills/source-validator/SKILL.md` |

## Specialist skills (Flutter & mobile delivery)

| skill_id | SKILL.md |
| --- | --- |
| `flutter-architect` | `docs/ai/11-skills/skills/flutter-architect/SKILL.md` |
| `flutter-coder` | `docs/ai/11-skills/skills/flutter-coder/SKILL.md` |
| `flutter-ui-designer` | `docs/ai/11-skills/skills/flutter-ui-designer/SKILL.md` |
| `flutter-decision-analyst` | `docs/ai/11-skills/skills/flutter-decision-analyst/SKILL.md` |
| `framework-advisor` | `docs/ai/11-skills/skills/framework-advisor/SKILL.md` |
| `widget-selector` | `docs/ai/11-skills/skills/widget-selector/SKILL.md` |
| `state-manager` | `docs/ai/11-skills/skills/state-manager/SKILL.md` |
| `package-selector` | `docs/ai/11-skills/skills/package-selector/SKILL.md` |
| `code-organizer` | `docs/ai/11-skills/skills/code-organizer/SKILL.md` |
| `module-designer` | `docs/ai/11-skills/skills/module-designer/SKILL.md` |
| `pattern-advisor` | `docs/ai/11-skills/skills/pattern-advisor/SKILL.md` |
| `security-auditor` | `docs/ai/11-skills/skills/security-auditor/SKILL.md` |
| `performance-analyst` | `docs/ai/11-skills/skills/performance-analyst/SKILL.md` |
| `test-engineer` | `docs/ai/11-skills/skills/test-engineer/SKILL.md` |
| `ci-engineer` | `docs/ai/11-skills/skills/ci-engineer/SKILL.md` |
| `business-analyst` | `docs/ai/11-skills/skills/business-analyst/SKILL.md` |
| `research-analyst` | `docs/ai/11-skills/skills/research-analyst/SKILL.md` |
| `debug-investigator` | `docs/ai/11-skills/skills/debug-investigator/SKILL.md` |
| `hybrid-integrator` | `docs/ai/11-skills/skills/hybrid-integrator/SKILL.md` |
| `sync-architect` | `docs/ai/11-skills/skills/sync-architect/SKILL.md` |
| `multiplatform-strategist` | `docs/ai/11-skills/skills/multiplatform-strategist/SKILL.md` |
| `plugin-engineer` | `docs/ai/11-skills/skills/plugin-engineer/SKILL.md` |
| `release-manager` | `docs/ai/11-skills/skills/release-manager/SKILL.md` |
| `observability-engineer` | `docs/ai/11-skills/skills/observability-engineer/SKILL.md` |

## AI-system skills (prompt / agent / eval)

| skill_id | SKILL.md |
| --- | --- |
| `prompt-architect` | `docs/ai/11-skills/skills/prompt-architect/SKILL.md` |
| `agent-architect` | `docs/ai/11-skills/skills/agent-architect/SKILL.md` |
| `eval-designer` | `docs/ai/11-skills/skills/eval-designer/SKILL.md` |

## Route wiring

Active skill sets per route: `tools/prompt-cli/routes.json` field `skills` (source of truth for automation).

## Related

- Contracts (detailed): `docs/ai/00-core/skill-contracts.md`
- Precedence: `docs/ai/00-core/skill-precedence-policy.md`
- Catalog (L1–L3): `docs/ai/11-skills/skill-catalog.md`
- Agent roles: `docs/ai/11-skills/agents/`
- Commands: `docs/ai/11-skills/commands/`

# Agent — skill index (Flutter / mobile prompt OS)

**Single navigation page** for all logical skills. Executable definitions live under `docs/ai/skill-system/definitions/<skill_id>/SKILL.md`. Registry and activation rules: `docs/ai/core/contracts/skill-registry.md`.

## Core skills

| skill_id | SKILL.md |
| --- | --- |
| `intent-router` | `docs/ai/skill-system/definitions/intent-router/SKILL.md` |
| `context-loader` | `docs/ai/skill-system/definitions/context-loader/SKILL.md` |
| `memory-curator` | `docs/ai/skill-system/definitions/memory-curator/SKILL.md` |
| `mcp-orchestrator` | `docs/ai/skill-system/definitions/mcp-orchestrator/SKILL.md` |
| `quality-grader` | `docs/ai/skill-system/definitions/quality-grader/SKILL.md` |
| `source-validator` | `docs/ai/skill-system/definitions/source-validator/SKILL.md` |

## Specialist skills (Flutter & mobile delivery)

| skill_id | SKILL.md |
| --- | --- |
| `flutter-architect` | `docs/ai/skill-system/definitions/flutter-architect/SKILL.md` |
| `flutter-coder` | `docs/ai/skill-system/definitions/flutter-coder/SKILL.md` |
| `flutter-ui-designer` | `docs/ai/skill-system/definitions/flutter-ui-designer/SKILL.md` |
| `flutter-decision-analyst` | `docs/ai/skill-system/definitions/flutter-decision-analyst/SKILL.md` |
| `framework-advisor` | `docs/ai/skill-system/definitions/framework-advisor/SKILL.md` |
| `widget-selector` | `docs/ai/skill-system/definitions/widget-selector/SKILL.md` |
| `state-manager` | `docs/ai/skill-system/definitions/state-manager/SKILL.md` |
| `package-selector` | `docs/ai/skill-system/definitions/package-selector/SKILL.md` |
| `code-organizer` | `docs/ai/skill-system/definitions/code-organizer/SKILL.md` |
| `module-designer` | `docs/ai/skill-system/definitions/module-designer/SKILL.md` |
| `pattern-advisor` | `docs/ai/skill-system/definitions/pattern-advisor/SKILL.md` |
| `security-auditor` | `docs/ai/skill-system/definitions/security-auditor/SKILL.md` |
| `performance-analyst` | `docs/ai/skill-system/definitions/performance-analyst/SKILL.md` |
| `test-engineer` | `docs/ai/skill-system/definitions/test-engineer/SKILL.md` |
| `ci-engineer` | `docs/ai/skill-system/definitions/ci-engineer/SKILL.md` |
| `business-analyst` | `docs/ai/skill-system/definitions/business-analyst/SKILL.md` |
| `research-analyst` | `docs/ai/skill-system/definitions/research-analyst/SKILL.md` |
| `debug-investigator` | `docs/ai/skill-system/definitions/debug-investigator/SKILL.md` |
| `hybrid-integrator` | `docs/ai/skill-system/definitions/hybrid-integrator/SKILL.md` |
| `sync-architect` | `docs/ai/skill-system/definitions/sync-architect/SKILL.md` |
| `multiplatform-strategist` | `docs/ai/skill-system/definitions/multiplatform-strategist/SKILL.md` |
| `plugin-engineer` | `docs/ai/skill-system/definitions/plugin-engineer/SKILL.md` |
| `release-manager` | `docs/ai/skill-system/definitions/release-manager/SKILL.md` |
| `observability-engineer` | `docs/ai/skill-system/definitions/observability-engineer/SKILL.md` |

## AI-system skills (prompt / agent / eval)

| skill_id | SKILL.md |
| --- | --- |
| `prompt-architect` | `docs/ai/skill-system/definitions/prompt-architect/SKILL.md` |
| `agent-architect` | `docs/ai/skill-system/definitions/agent-architect/SKILL.md` |
| `eval-designer` | `docs/ai/skill-system/definitions/eval-designer/SKILL.md` |

## Route wiring

Active skill sets per route: `tools/prompt-powershell/routes.json` field `skills` (source of truth for automation).

## Related

- Contracts (detailed): `docs/ai/core/contracts/skill-contracts.md`
- Precedence: `docs/ai/core/policies/skill-precedence-policy.md`
- Catalog (L1–L3): `docs/ai/skill-system/skill-catalog.md`
- Agent roles: `docs/ai/skill-system/agents/`
- Commands: `docs/ai/skill-system/commands/`

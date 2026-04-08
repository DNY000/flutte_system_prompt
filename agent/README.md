# Agent (core orchestration)

Orchestration for the **Flutter / mobile** prompt operating system: resolve route, activate skills, load context, enforce one output contract.

## Entry points

| Layer | Path | Role |
| --- | --- | --- |
| **Skill index** | `agent/SKILLS.md` | All `skill_id` → `SKILL.md` links |
| **PowerShell CLI** | `tools/prompt-cli/aiprompt.ps1` | Build prompt packages from `routes.json` |
| **TypeScript** | `tools/prompt-runtime-ts/` | Router parity with PS, `--explain` (top candidates + command/route hints), `npm run validate-manifest`, skill order per `skill-precedence-policy.md` |
| **Runtime state** | `.promptos/` | Plans, runs, logs, metrics (mobile-scoped) |

## Skill system (no duplication)

- **Definitions:** `docs/ai/11-skills/skills/<skill_id>/SKILL.md` (one folder per id)
- **Registry & rules:** `docs/ai/00-core/skill-registry.md`, `skill-contracts.md`, `skill-precedence-policy.md`
- **Human “table of contents”:** this folder → `SKILLS.md`

Do not put duplicate long skill prose under `agent/`; extend `SKILL.md` or `skill-contracts.md` instead.

## Agent roles (profiles)

Role docs (ask / plan / execute / review): `docs/ai/11-skills/agents/`

These are **profiles** that combine skills; they are not separate `skill_id` entries in `routes.json`.

## Hermes-style loop (future)

Full persistent agent loop (gateway, scheduled runs) is optional. Today: use `.promptos/PLANNING_WORKFLOW.md` + CLI/TS for execution.

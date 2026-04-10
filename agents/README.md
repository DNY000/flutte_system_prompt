# Agents & Core Orchestration

Orchestration for the Flutter / mobile prompt operating system: resolve route, activate skills, load context, and enforce one output contract.

## Entry Points

| Layer | Path | Role |
| --- | --- | --- |
| **Skill index** | `agents/SKILLS.md` | Flat index of all `skill_id` -> `SKILL.md` links |
| **Operator surface** | `agents/`, `commands/`, `contexts/`, `manifests/` | Thin wrappers and catalogs for daily usage |
| **PowerShell CLI** | `tools/prompt-powershell/prompt-cli.ps1` | Build prompt packages from `routes.json` |
| **TypeScript runtime** | `tools/prompt-runtime-typescript/` | Route parity with PowerShell, `--explain`, catalog validation, and skill ordering |
| **Runtime state** | `.promptos/` | Plans, runs, logs, and metrics |

## Operator Agents

Thin operator-facing agent profiles for the prompt operating system.
These files are a discoverability surface, not a second source of truth.

Included Agents:
- `ask.md`
- `plan.md`
- `execute.md`
- `review.md`
- `architect.md`
- `prompt-architect.md`

Use these files as thin entry wrappers. If behavior changes, update the canonical docs under `docs/ai/` first, then update this surface.

**Canonical sources:**
- role profiles: `docs/ai/skill-system/agents/`
- skill definitions: `docs/ai/skill-system/definitions/`
- route rules: `docs/ai/core/routing/routing-rules.md`

## Skill System

- definitions: `docs/ai/skill-system/definitions/<skill_id>/SKILL.md`
- registry and rules: `docs/ai/core/contracts/skill-registry.md`, `docs/ai/core/contracts/skill-contracts.md`, `docs/ai/core/policies/skill-precedence-policy.md`
- human-readable table of contents: `agents/SKILLS.md`

Do not duplicate long skill definitions under `agents/`.

## Agent Roles

Canonical role docs live under `docs/ai/skill-system/agents/`.
These are profiles that combine skills; they are not separate `skill_id` entries in `routes.json`.

## Today vs Future

Full persistent agent loops remain optional.
Today, use `.promptos/PLANNING_WORKFLOW.md` together with the CLI and TypeScript runtime.

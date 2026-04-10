# Skills runtime structure

**Machine-readable index of every skill:** `agents/SKILLS.md` (repo root).

This folder holds **content**: agents, commands, per-`skill_id` SKILL packs, plugins, hooks.

## Canonical guides (read first)

| Doc | Role |
| --- | --- |
| `SKILL-AUTHORING.md` | How to write skills with **enough context, constraints, numbered steps, validation loops** (aligned with common Agent Skills practice: progressive disclosure, concrete examples). |
| `skill-execution-pipeline.md` | Full **request → route → skills → context → execute → verify → memory** chain. |
| `skill-catalog.md` | L1–L3 levels, groups, minimum production set, promotion criteria. |

Registry and wiring: `docs/ai/00-core/contracts/skill-registry.md`, `tools/prompt-cli/routes.json`.

Thin operator-facing wrappers live at the repo root under:

- `agents/`
- `commands/`
- `contexts/`
- `manifests/`

Those wrappers should point back to this folder and other canonical docs rather than duplicating them.

## Subfolders

- `agents/`: role profiles (ask, plan, execute, review)
- `commands/`: command-to-route mapping (`ask`, `plan`, `review`, `execute`, `ship-check`)
- `skills/`: one `SKILL.md` per `skill_id` (canonical definitions)
- `plugins/`: extension contracts and plugin manifests
- `hooks/`: lifecycle hooks for runtime checkpoints

Per-skill folder layout under `skills/<skill-id>/`:

- required: `SKILL.md`
- optional: `references.md`, `examples.md`, `tests.md`, `CHANGELOG.md` — use when `SKILL.md` would exceed ~500 lines; load on demand only

## Precedence

Use `docs/ai/00-core/policies/skill-precedence-policy.md`:

1. project-local
2. workspace-global
3. built-in

# Skills runtime structure

**Machine-readable index of every skill:** `agent/SKILLS.md` (repo root).

This folder holds **content**: agents, commands, per-`skill_id` SKILL packs, plugins, hooks.

## Subfolders

- `agents/`: role profiles (ask, plan, execute, review)
- `commands/`: command-to-route mapping (`ask`, `plan`, `review`, `execute`, `ship-check`)
- `skills/`: one `SKILL.md` per `skill_id` (canonical definitions)
- `plugins/`: extension contracts and plugin manifests
- `hooks/`: lifecycle hooks for runtime checkpoints

Per-skill folder layout under `skills/<skill-id>/`:

- required: `SKILL.md`
- optional: `tests.md`, `examples.md`, `CHANGELOG.md`

## Precedence

Use `docs/ai/00-core/skill-precedence-policy.md`:

1. project-local
2. workspace-global
3. built-in

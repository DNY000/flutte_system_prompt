# Skill Precedence Policy

## Activation list (skill IDs)

For a single request, build one **ordered list** of unique `skill_id` values:

1. **project-local** skills first (in the order provided)
2. then **workspace-global** skills not already listed
3. then **built-in** route skills from `routes.json` not already listed

Duplicates appear **once**, at the **first** position where they were introduced (project beats global beats built-in).

Reference implementation: `tools/prompt-runtime-typescript/src/skills.ts` → `resolveSkillsByPrecedence`.

## Rules

- project-local may override **implementation pack / SKILL prose** for the same `skill_id` but not safety constraints
- global skills should provide organization defaults across projects
- built-in route skills are the baseline when project/global do not add that `skill_id`
- any override must keep the same `skill_id`

## Validation

- route skills must resolve to one effective implementation **per skill_id** when loading `SKILL.md` content (loader picks project > global > built-in pack)
- if multiple scopes exist, log selected source in runtime trace

# Item completion plan: operator surface layer

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260408-operator-surface-layer |
| **owner** | Codex |
| **status** | done |
| **risk_level** | medium |
| **primary_route_id** | agent-system-roadmap |
| **output_contract** | improvement-roadmap-v1 |

## 1. Problem & goal

- **Problem to solve:** The repo has a strong canonical prompt architecture, but it lacks a thin top-level operator surface comparable to larger agent platforms.
- **Expected outcome (one sentence):** Add top-level `agents/`, `commands/`, `contexts/`, and `manifests/` surfaces that improve discoverability without forking canonical prompt content.
- **Non-mobile / out of scope:** full install lifecycle, persistent session runtime, and hook executors

## 2. Prerequisites

- **Docs / policy:** `docs/ai/README.md`, `docs/ai/skill-system/README.md`, `docs/ai/skill-system/agents/`, `docs/ai/skill-system/commands/`, `docs/ai/core/routing/routing-rules.md`
- **Tools:** `tools/prompt-runtime-typescript`, `tools/prompt-powershell`, repo-level README
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add thin top-level wrappers for agents, commands, and curated contexts.
2. Add a catalog manifest describing the new operator surface.
3. Validate the catalog against canonical routes, skills, and file paths.
4. Update repo docs so the new layer is visible from the root.

## 4. Flutter / mobile impact

- **Screens / modules:** `none`
- **Native / plugin:** no
- **Build / store / CI:** yes; manifest validation expands
- **Performance / memory / jank:** no

## 5. Definition of done

- [x] Code / docs / config updated within scope
- [x] No open TODOs left inside this item's scope
- [x] Eval / checklist items under Verify are passing
- [x] Memory / changelog (if needed) has owner and reviewer

Memory note: the new operator surface is intentionally thin and documented through repo docs plus the validated surface catalog; no separate memory draft was needed.

## 6. Verify

- [x] `../checklists/pre-completion-checklist.md` completed
- [x] `run-evals` / CI (if routes or contracts changed)
- [x] Manual mobile checks (if UI / plugin / release): short note

Manual mobile note: not applicable; no app UI, plugin, or release artifact changed.

## 7. Risk & rollback

- **Remaining risk:** The new operator surface is intentionally thin and manual; a future generator could reduce drift further.
- **Rollback:** remove the new top-level surface folders and catalog validation changes

## 8. After completion

- [x] Run snapshot (if any): `none`
- [x] Memory draft (if needed): `none`
- [x] Weekly metrics (if you track): `none`

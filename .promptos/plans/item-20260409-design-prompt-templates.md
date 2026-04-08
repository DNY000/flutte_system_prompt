# Item completion plan: design prompt templates

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260409-design-prompt-templates |
| **owner** | Codex |
| **status** | completed |
| **risk_level** | medium |
| **primary_route_id** | design-screen |
| **output_contract** | design-spec-v1 |

## 1. Problem & goal

- **Problem to solve:** The current design route is still too abstract and lacks reusable prompt templates and a detailed design brief structure for screen, component, and design-system requests.
- **Expected outcome (one sentence):** Add stronger design prompt templates, enrich the design task prompt, and wire the templates into the design skill and template surfaces.
- **Non-mobile / out of scope:** visual asset generation and runtime UI code changes

## 2. Prerequisites

- **Docs / policy:** `docs/ai/02-tasks/`, `docs/ai/04-templates/`, `docs/ai/11-skills/skills/`
- **Tools:** repo docs, manifest validation, prompt evals
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add a reusable design prompt template library.
2. Enrich the design task prompt with a fuller design brief and output guidance.
3. Update the design skill and related template/index docs to surface the new templates.
4. Run validation and update this task record.

## 4. Flutter / mobile impact

- **Screens / modules:** `none`
- **Native / plugin:** none
- **Build / store / CI:** docs and validation only
- **Performance / memory / jank:** no runtime impact

## 5. Definition of done

- [x] Code / docs / config updated within scope
- [x] No open TODOs left inside this item's scope
- [x] Eval / checklist items under Verify are passing
- [x] Memory / changelog (if needed) has owner and reviewer

## 6. Verify

- [x] `../checklists/pre-completion-checklist.md` completed
- [x] `run-evals` / CI (if routes or contracts changed)
- [x] Manual mobile checks (if UI / plugin / release): docs-only change, no runtime mobile verification needed

## 7. Risk & rollback

- **Remaining risk:** The templates remain guide-driven and still rely on the existing `design-spec-v1` contract rather than introducing a new contract family.
- **Rollback:** remove the new template doc and revert the related prompt and skill updates

## 8. After completion

- [ ] Run snapshot (if any): `none`
- [ ] Memory draft (if needed): `none`
- [ ] Weekly metrics (if you track): `none`

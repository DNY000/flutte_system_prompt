# Item completion plan: flutter widget by widget examples

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260409-flutter-widget-by-widget-examples |
| **owner** | Codex |
| **status** | completed |
| **risk_level** | low |
| **primary_route_id** | prompt-system-roadmap |
| **output_contract** | improvement-roadmap-v1 |

## 1. Problem & goal

- **Problem to solve:** Flutter UI docs are still too abstract for widget-by-widget requests and do not provide enough concrete per-widget situations with direct code.
- **Expected outcome (one sentence):** Add a widget-by-widget Flutter UI pack with concrete scenarios and code examples, then wire it into the skill and retrieval surface.
- **Non-mobile / out of scope:** runtime app code changes

## 2. Prerequisites

- **Docs / policy:** `docs/ai/guides/flutter/`, `docs/ai/skill-system/definitions/`
- **Tools:** repo docs, TypeScript manifest validation, prompt evals
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add a Flutter UI pack with per-widget situations and code snippets.
2. Update UI indexes and relevant Flutter skills to reference the new pack.
3. Run validation and close this task record.

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

- **Remaining risk:** Some advanced widgets still remain grouped rather than one-file-per-widget.
- **Rollback:** remove the new widget examples pack and related references

## 8. After completion

- [ ] Run snapshot (if any): `none`
- [ ] Memory draft (if needed): `none`
- [ ] Weekly metrics (if you track): `none`

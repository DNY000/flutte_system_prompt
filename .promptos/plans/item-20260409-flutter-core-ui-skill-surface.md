# Item completion plan: flutter core ui skill surface

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260409-flutter-core-ui-skill-surface |
| **owner** | Codex |
| **status** | completed |
| **risk_level** | low |
| **primary_route_id** | prompt-system-roadmap |
| **output_contract** | improvement-roadmap-v1 |

## 1. Problem & goal

- **Problem to solve:** Existing Flutter UI packs cover several framework basics, but the skill surface does not explicitly expose design-system/base-widget choices, gestures, shortcuts, and keyboard-focus guidance strongly enough.
- **Expected outcome (one sentence):** Add the missing core Flutter UI leaf packs and wire them into the Flutter skills and indexes so they are discoverable during retrieval.
- **Non-mobile / out of scope:** non-Flutter UI frameworks and runtime code changes

## 2. Prerequisites

- **Docs / policy:** `docs/ai/guides/flutter/`, `docs/ai/skill-system/definitions/`
- **Tools:** repo docs, TypeScript manifest validation, prompt evals
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add a design-system and base-widget Flutter UI pack.
2. Add a gestures, shortcuts, and focus Flutter UI pack.
3. Update Flutter section indexes and Flutter skill references so the new packs are discoverable.
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

- **Remaining risk:** Some broad Flutter official-doc topics still map to compact packs rather than one-to-one leaf guides.
- **Rollback:** remove the new UI packs and skill/index references

## 8. After completion

- [ ] Run snapshot (if any): `none`
- [ ] Memory draft (if needed): `none`
- [ ] Weekly metrics (if you track): `none`

# Item completion plan: <short name>

> Use this file **before** implementation or before merge. Default scope: **Flutter / mobile** (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-YYYYMMDD-<slug> |
| **owner** | |
| **status** | draft → in_progress → done / cancelled |
| **risk_level** | low / medium / high |
| **primary_route_id** | (if any; or `n/a`) |
| **output_contract** | (if any; or `n/a`) |

## 1. Problem & goal

- **Problem to solve:**
- **Expected outcome (one sentence):**
- **Non-mobile / out of scope:** (if any; otherwise `none`)

## 2. Prerequisites

- **Docs / policy:** (paths under `docs/ai/...`)
- **Tools:** (CLI, TS runtime, CI, iOS/Android build machines, …)
- **Access:** (store, repo, secrets — do not write secret values)
- **People / team dependencies:**

## 3. How (execution steps — ordered)

1.
2.
3.

## 4. Flutter / mobile impact

- **Screens / modules:** `lib/...`
- **Native / plugin:** `android/` `ios/` (yes / no)
- **Build / store / CI:** (yes / no; short note)
- **Performance / memory / jank:** (yes / no)

## 5. Definition of done

- [ ] Code / docs / config updated within scope
- [ ] No open TODOs left inside this item’s scope
- [ ] Eval / checklist items under Verify are passing
- [ ] Memory / changelog (if needed) has owner and reviewer

## 6. Verify

- [ ] `../checklists/pre-completion-checklist.md` completed
- [ ] `run-evals` / CI (if routes or contracts changed)
- [ ] Manual mobile checks (if UI / plugin / release): short note

## 7. Risk & rollback

- **Remaining risk:**
- **Rollback:** (revert commit / disable flag / restore route, …)

## 8. After completion

- [ ] Run snapshot (if any): `../runs/...`
- [ ] Memory draft (if needed): `../memory-drafts/...`
- [ ] Weekly metrics (if you track): `../metrics/...`

# Item completion plan: flutter skill gap passes

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260408-flutter-skill-gap-passes |
| **owner** | Codex |
| **status** | completed |
| **risk_level** | medium |
| **primary_route_id** | prompt-system-roadmap |
| **output_contract** | improvement-roadmap-v1 |

## 1. Problem & goal

- **Problem to solve:** Flutter guide packs and skill examples are still too thin for practical engineering topics such as image widget choice, native channel calls, model layering, and implementation-level mobile security.
- **Expected outcome (one sentence):** Add missing Flutter engineering guidance in three iterative passes, reassessing gaps after each pass and expanding indexes and skill examples accordingly.
- **Non-mobile / out of scope:** non-Flutter ecosystems and full plugin runtime automation

## 2. Prerequisites

- **Docs / policy:** `docs/ai/08-guides/flutter/`, `docs/ai/11-skills/skills/`, `docs/ai/02-tasks/`, `docs/ai/00-core/policies/context-loading-rules.md`
- **Tools:** repo docs, TypeScript manifest validation, prompt evals
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Pass 1: add the directly requested missing guidance for image handling, native channel calls, model layering, and security implementation.
2. Pass 2: reassess the remaining Flutter engineering gaps and add testing, package-selection, and model-organization packs.
3. Pass 3: reassess again and add safety, evolution, and hardening packs that close the next most obvious holes.
4. Update section indexes, retrieval rules, and skill examples so the new packs are discoverable.

## 4. Flutter / mobile impact

- **Screens / modules:** `none`
- **Native / plugin:** no runtime plugin change; documentation only
- **Build / store / CI:** yes; docs and validation flow should remain green
- **Performance / memory / jank:** no direct runtime impact

## 5. Definition of done

- [x] Code / docs / config updated within scope
- [x] No open TODOs left inside this item's scope
- [x] Eval / checklist items under Verify are passing
- [x] Memory / changelog (if needed) has owner and reviewer

## 6. Verify

- [x] `../checklists/pre-completion-checklist.md` completed
- [x] `run-evals` / CI (if routes or contracts changed)
- [x] Manual mobile checks (if UI / plugin / release): docs-only change, no runtime UI / plugin / release validation needed

## 7. Risk & rollback

- **Remaining risk:** The system may still miss niche Flutter topics, but these passes should close the largest engineering guidance gaps.
- **Rollback:** remove the new guide packs, index updates, and skill example changes

## 8. After completion

- [ ] Run snapshot (if any): `none`
- [ ] Memory draft (if needed): `none`
- [ ] Weekly metrics (if you track): `none`

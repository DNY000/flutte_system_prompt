# Item completion plan: output verification layer

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260408-output-verification-layer |
| **owner** | Codex |
| **status** | done |
| **risk_level** | medium |
| **primary_route_id** | prompt-system-roadmap |
| **output_contract** | improvement-roadmap-v1 |

## 1. Problem & goal

- **Problem to solve:** The prompt system defines `Execute -> Verify`, but the current toolchain only validates routing, manifests, and contract mappings. It does not verify generated answer artifacts against the selected output contract.
- **Expected outcome (one sentence):** Add a real generated-output verification layer with automated pass/fail fixtures and wire it into local and CI eval commands.
- **Non-mobile / out of scope:** none

## 2. Prerequisites

- **Docs / policy:** `docs/ai/core/system/execution-flow.md`, `docs/ai/core/system/operating-model.md`, `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/policies/prompt-release-checklist.md`, `tools/prompt-powershell/evals/task-quality-rubric.md`
- **Tools:** `tools/prompt-powershell/run-evals.ps1`, `tools/prompt-runtime-typescript`, GitHub Actions workflow
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add a TypeScript artifact verifier that checks top-level contract sections and key contract-specific structural rules.
2. Add regression fixtures with expected pass/fail behavior for generated output artifacts.
3. Add runtime scripts and CI/local eval integration so the artifact verifier runs with the rest of prompt-system checks.
4. Update canonical docs to describe the new verification layer and record the durable prompt-system decision if needed.

## 4. Flutter / mobile impact

- **Screens / modules:** `none`
- **Native / plugin:** no
- **Build / store / CI:** yes; prompt-system CI and local eval commands change
- **Performance / memory / jank:** no

## 5. Definition of done

- [x] Code / docs / config updated within scope
- [x] No open TODOs left inside this item's scope
- [x] Eval / checklist items under Verify are passing
- [x] Memory / changelog (if needed) has owner and reviewer

Memory note: durable release guidance was recorded in `docs/ai/memory/decisions.md`; final reviewer remains the repository maintainer.

## 6. Verify

- [x] `../checklists/pre-completion-checklist.md` completed
- [x] `run-evals` / CI (if routes or contracts changed)
- [x] Manual mobile checks (if UI / plugin / release): short note

Manual mobile note: not applicable; no app UI, native plugin, or store flow changed.

## 7. Risk & rollback

- **Remaining risk:** The verifier is intentionally structural; it reduces contract regressions but does not replace human quality review or live model benchmarking.
- **Rollback:** revert the verifier files, fixture suite, and CI/script wiring in one commit

## 8. After completion

- [x] Run snapshot (if any): `none`
- [x] Memory draft (if needed): `none`
- [x] Weekly metrics (if you track): `none`

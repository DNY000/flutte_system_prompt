# Planning workflow — required before marking any work item complete

Whenever you finish an issue (prompt feature, new route, eval change, skill addition, and so on), **do not treat it as done** until there is a plan file under `.promptos/plans/` and you have completed the verification steps below.

**System scope:** Dart, Flutter, and **mobile** apps (iOS/Android). Plans default to mobile-first unless you document an exception (see `SCOPE.md`).

---

## 0 — Intake

Answer briefly:

| Question | Notes |
| --- | --- |
| **What is the problem / goal?** | One concrete outcome sentence |
| **Prompt OS or Flutter app work?** | Example: edit `routes.json` vs refactor `lib/` |
| **Who owns it?** | Person responsible for merge / release |
| **Risk** | low / medium / high (auth, store, plugin, user data → often high) |

If risk is **high**: use a review- or architecture-style contract before implementation (see `docs/ai/00-core/routing/routing-rules.md`).

---

## 1 — Plan (required)

1. Create a plan file under `.promptos/plans/`:
   - Use **`item-completion-plan-template.md`** for any “finish a slice of the system” work.
   - Or **`approved-plan-template.md`** for large app architecture / migration plans.
2. The file must include:
   - **Prerequisites:** dependencies (docs, files, access, tools)
   - **How:** ordered execution steps
   - **Definition of done:** pass/fail criteria
   - **Verification:** eval, manual mobile testing, or release checklist
3. Pick **one** primary `route_id` / `output_contract` if the work touches the AI prompt system (for tracing in `runs/`).

**File naming:** `plans/item-<YYYYMMDD>-<slug>.md` (see `CONVENTIONS.md`).

---

## 2 — Execute

- Follow the order in the plan’s “Execution steps”.
- For important CLI / runtime calls: save a snapshot under `runs/` (template `run-snapshot-template.json`).
- Errors / blockers: log under `logs/` (follow `LOGGING_POLICY.md`); never log secrets.

---

## 3 — Verify

Before closing the work item, complete **`checklists/pre-completion-checklist.md`** (or equivalent sections in the plan itself).

At minimum:

- Check off each item in the plan’s **Definition of done**.
- If you changed `routes.json` or contracts: run `tools/prompt-cli/run-evals.ps1` (or equivalent CI).
- If you touched mobile store / code signing / native plugins: add a manual confirmation line in the plan.

---

## 4 — Persist

- If there is a **decision / pattern / recurring mistake:** draft in `memory-drafts/` then merge into `docs/ai/03-memory/` per `memory-governance.md`.
- Update **`metrics/`** when you track weekly or per-release stats (template `mobile-weekly-export.template.json`).
- For prompt releases: use `docs/ai/00-core/policies/prompt-release-checklist.md` and `docs/ai/10-releases/`.

---

## System documentation links

- Operating model: `docs/ai/00-core/system/operating-model.md`
- Release checklist: `docs/ai/00-core/policies/prompt-release-checklist.md`
- Memory governance: `docs/ai/03-memory/memory-governance.md`
- Incident loop: `docs/ai/03-memory/incident-to-memory-loop.md`

# `.promptos` — runtime state (Flutter / mobile prompt OS)

This directory holds **durable workspace state** for the prompt operating system.  
**Scope:** Dart, Flutter, and mobile delivery (iOS, Android, and Flutter targets such as web/desktop only when they affect the **mobile** product). Everything here should default to **mobile-first** assumptions.

## Rule: no “completion” without a plan

For every completed issue, you **must** have a plan under **`.promptos/plans/`** (see **`PLANNING_WORKFLOW.md`**) and complete the checklist in **`checklists/pre-completion-checklist.md`**.  
Default template for small items: **`plans/item-completion-plan-template.md`** (inside `.promptos/plans/`).

## Principles

- **Mobile-first:** plans, runs, and metrics assume Flutter apps, store releases, device matrix, and platform channels unless explicitly marked otherwise.
- **One primary route per run:** each snapshot in `runs/` must record a single resolved `route_id` and contract.
- **No secrets in git:** do not commit API keys, keystores, provisioning profiles, or internal URLs. Redact in `logs/` and `metrics/`.
- **Promote to docs after review:** approved patterns and decisions move to `docs/ai/03-memory/` via `memory-governance.md`; `.promptos/memory-drafts/` is staging only.

## Folder map

| Folder | Purpose |
| --- | --- |
| `.promptos/plans/` | Approved or in-review **implementation / architecture** plans for Flutter work (feature, module, migration). |
| `checklists/` | **Gates** before marking work done (e.g. pre-completion checklist). |
| `runs/` | **Per-invocation metadata:** query, route, contract, optional device/platform context, timestamps. |
| `logs/` | **Structured log lines** or failure traces from CLI/automation (redacted). |
| `metrics/` | **Aggregates:** route hit rates, eval pass rates, mobile-specific gates (e.g. release readiness). |
| `memory-drafts/` | **Pending** `decisions` / `patterns` / `mistakes` snippets before merge into `docs/ai/03-memory/`. |

## Flutter / mobile defaults (record in every plan or run)

When filling templates, prefer explicit fields:

- **Flutter SDK / Dart** version (or “unknown”)
- **Targets:** iOS, Android, or both; min OS versions if known
- **State management & routing** (if relevant)
- **Plugins / platform channels** touched
- **Release impact:** store submission, OTA, feature flags

## Git hygiene

- Safe defaults: commit **templates and READMEs**; treat `logs/`, `runs/`, and `metrics/` as **optional local artifacts**.
- If you commit real runs, scrub user data and paths or use `examples/` copies only.

See `SCOPE.md` for boundary rules, `CONVENTIONS.md` for naming, and **`PLANNING_WORKFLOW.md`** for the mandatory plan → execute → verify → persist loop.

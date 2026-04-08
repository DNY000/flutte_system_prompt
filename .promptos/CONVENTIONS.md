# Naming & file conventions

All paths below are under **`.promptos/`** unless noted.

## Plans

- Large architecture / app plan: `plans/plan-<YYYYMMDD>-<short-slug>.md`
  - Example: `plans/plan-20260408-auth-module-boundary.md`
- Item completion (mandatory for finishing any tracked issue): `plans/item-<YYYYMMDD>-<short-slug>.md`
  - Example: `plans/item-20260408-add-route-debug-triage-patterns.md`

## Runs

- File name: `runs/run-<YYYYMMDD>-<request-id-or-short-hash>.json`
- `request-id` can be UUID or `local-001` for manual tests.

## Logs

- File name: `logs/log-<YYYYMMDD>.log` (append) or one file per session.
- Never log full user queries that contain PII; truncate or hash identifiers.

## Metrics

- File name: `metrics/metrics-<YYYY-Www|YYYYMMDD>.json` for weekly or daily exports.

## Memory drafts

- File name: `memory-drafts/draft-<type>-<slug>.md` where `type` is `decision` | `pattern` | `mistake`.

# Pre-completion checklist (Flutter / mobile prompt OS)

Use alongside the plan file in `plans/item-*.md`. Mark **done** only when each item matches the actual scope of work.

## Plan & scope

- [ ] Plan file exists under `.promptos/plans/` (template `item-completion-plan-template.md` or `approved-plan-template.md`)
- [ ] Goal and **definition of done** are explicit and match the real changes
- [ ] **Mobile-first** scope checked (or exceptions documented in the plan)

## Quality & safety

- [ ] No secrets / PII committed under `logs/`, `runs/`, `metrics/`
- [ ] If risk is **high:** review / trade-offs documented in docs or PR

## Prompt system (route, contract, or eval changes)

- [ ] `tools/prompt-cli/routes.json` (and tables in `docs/ai/00-core/routing/routing-rules.md` if applicable) are in sync
- [ ] `docs/ai/00-core/contracts/output-contracts.md` updated if contract mapping changed
- [ ] `run-evals` or prompt-eval CI is green

## Mobile / Flutter (app or native touchpoints)

- [ ] Platforms (iOS / Android) and plugin / native channel impact stated
- [ ] Minimum test plan described (device / flavor / store if relevant)

## Knowledge durable capture

- [ ] For lasting decisions: memory draft + merge per `memory-governance.md`
- [ ] For prompt releases: `prompt-release-checklist.md` + `docs/ai/10-releases/` when needed

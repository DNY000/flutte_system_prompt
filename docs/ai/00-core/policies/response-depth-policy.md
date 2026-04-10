# Response Depth Policy

Control answer depth by risk, context completeness, and user mode.

## Inputs

- risk_level: `low`, `medium`, `high`
- context_completeness: `low`, `medium`, `high`
- user_mode: `ask`, `plan`, `execute`, `review`

## Depth Rules

- low risk + high context: short answer, minimal assumptions
- medium risk or medium context: moderate detail with explicit assumptions
- high risk or low context: deeper analysis, explicit trade-offs, stronger validation guidance

## Mode Overrides

- ask: concise decision first, expand only where ambiguity exists
- plan: include phased approach and decision checkpoints
- execute: focus on concrete steps, target files, test impact
- review: findings first, ordered by severity, evidence required

## Section Budget Guidance

- low depth: 4-8 bullets total
- medium depth: 8-16 bullets total
- high depth: 12-24 bullets total

## Hard Constraints

- never break the selected output contract
- never hide assumptions when context is incomplete
- for high risk, always include rollback or mitigation guidance

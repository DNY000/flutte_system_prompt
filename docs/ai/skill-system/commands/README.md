# Commands Mapping

Command surface for consistent daily workflows.

## Goal

Map a high-level operator command to the route families and response bias it should prefer.

## Commands

- `ask`: evidence-first analysis with no execution bias
- `plan`: architecture, migration, and phased roadmap design
- `review`: findings-first audits, triage, and risk discovery
- `execute`: implementation-oriented output with target files and ordered steps
- `ship-check`: release readiness, gate review, and rollback thinking

## Selection Rules

- use `ask` when the user primarily wants explanation, comparison, or research framing
- use `plan` when the answer should sequence work before code changes happen
- use `review` when the answer should identify defects, gaps, or risks first
- use `execute` when the task is implementation-oriented and should bias toward action
- use `ship-check` when release safety matters more than feature ideation

## Runtime Notes

- command choice does not replace route resolution; routing still comes from the manifest and query matchers
- the TypeScript runtime uses commands as alignment hints, not as route overrides
- if command and route conflict, the system should warn rather than silently force a different route
- when the runtime supports structured outputs, commands should preserve the schema mapped from the chosen route contract

## References

- `command-routing-map.md`
- `docs/ai/core/routing/routing-rules.md`
- `tools/prompt-runtime-typescript/src/commands.ts`

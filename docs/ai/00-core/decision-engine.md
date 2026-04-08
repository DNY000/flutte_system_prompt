# Decision Engine

Use this engine for all Flutter decision questions.

## Goal

Return the best default choice for the current problem with minimal token cost.

Do not dump all known rules.

## Execution Order

1. classify the problem domain
2. load the smallest relevant domain index
3. load the section examples file when the query is ambiguous or weakly specified
4. load at most 2 leaf rule packs
5. identify the dominant context signals
6. choose one default answer
7. mention only the 1 or 2 realistic competing options
8. explain what condition would change the answer

## Output Discipline

- lead with the winning choice
- keep the comparison narrow
- reject over-engineering explicitly
- do not list every possible API
- do not repeat framework basics unless they change the decision

## Decision Heuristics

- prefer SDK-first
- prefer local ownership before shared ownership
- prefer feature-level scope before app-wide scope
- prefer stable testable choices over fashionable ones
- if a package becomes foundational, escalate to architecture review

## Token Rules

- load one domain index first
- load one section examples file only when recognition needs more context
- load one or two subrule files only
- never load the full Flutter rule set by default
- use `decision-matrix-v1` for comparison questions

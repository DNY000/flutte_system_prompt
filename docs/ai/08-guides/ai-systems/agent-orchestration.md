# Agent Orchestration Pack

## Use For

- single agent vs multi-agent design
- specialist role boundaries
- handoff rules
- supervisor patterns
- tool ownership
- traceable execution

## Default Decisions

- start with one strong primary agent
- add specialist agents only when responsibility, tools, or evaluation criteria diverge clearly
- keep one aggregator or supervisor responsible for the final merged answer
- give each specialist one clear output and one clear ownership boundary
- keep handoffs explicit and observable

## Decision Switches

- if the next step depends immediately on the answer, keep the work local instead of delegating
- if two tasks are independent and expensive, split them into separate agents
- if an agent uses different tools or expertise, split it sooner
- if traces are hard to understand, the orchestration is too fragmented

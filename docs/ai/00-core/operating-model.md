# Prompt Operating Model

This system should run as an operating model, not as one large prompt.

## Execution Pipeline

1. `Normalize`
   Convert the raw user request into a clean task statement.
2. `Route`
   Detect intent and choose the correct route.
3. `Load Context`
   Load only the context layers needed for that route.
4. `Load Skills`
   Activate the logical skills needed for the task.
5. `Resolve Output`
   Pick one output contract and enforce it.
6. `Execute`
   Produce the answer, plan, patch, or review.
7. `Verify`
   Apply quality gates.
8. `Persist`
   Write durable learnings to memory files.

## Minimal Runtime State

Every task should produce this internal state:

- request_id
- primary_intent
- route_id
- output_contract
- required_context
- active_skills
- risk_level
- research_needed
- mcp_needed
- memory_write

## Hard Rules

- one primary route per request
- output must follow one contract, not a mix of many
- only load extra context if it changes the answer materially
- external research is optional by default, mandatory when time-sensitive accuracy matters
- memory updates happen only for durable knowledge

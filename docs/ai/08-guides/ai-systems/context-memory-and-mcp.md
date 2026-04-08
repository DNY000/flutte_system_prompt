# Context Memory And MCP Pack

## Use For

- retrieval architecture
- memory curation
- MCP integration
- live data connectors
- context window discipline

## Default Decisions

- keep stable project facts in short context files
- keep durable reusable knowledge in memory files, not in every prompt
- use MCP for live or structured data that should not be copied manually
- load the smallest context that changes the answer materially
- review memory entries before treating them as durable truth

## Decision Switches

- if data changes over time, prefer MCP or research over frozen prompt text
- if memory becomes noisy, deduplicate and summarize before adding more
- if connectors expose too much irrelevant data, narrow the retrieval boundary
- if the AI needs the same live facts repeatedly, promote them into an MCP workflow rather than repeating manual context

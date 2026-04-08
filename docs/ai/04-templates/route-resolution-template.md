# Route Resolution Template

Use this block internally before answering.

```text
Route Resolution
- primary_intent:
- secondary_intents:
- route_id:
- output_contract:
- matched_pattern:
- active_sections:
- active_packs:
- risk_level:
- mcp_needed:
- research_needed:
- multi_agent_mode:
- memory_write:

Required Context
- <list only the files that materially change the answer>

Required Skills
- <list effective skill ids in execution order>

Optional Notes
- route_override:
- contract_override:
```

Rules:

- choose one primary route
- keep secondary intents short
- do not skip output_contract
- list only the context that materially changes the answer
- if the route is ambiguous, state the assumption
- if the user forces a route or contract, record that override explicitly

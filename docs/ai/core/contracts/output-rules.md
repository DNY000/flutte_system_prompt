# Output Rules

Use clean Markdown as the human-readable rendering layer.

Rules:

- if the runtime supports structured outputs, use the matching schema from `structured-output-schemas.json`
- render the same fields into the selected markdown contract when a human-readable artifact is required
- keep answers short unless the user asks for depth
- prefer compact sections over long prose
- avoid repeating project context that is already known
- separate facts, assumptions, and recommendations
- include versions and dates when live external facts matter
- if code is suggested, state where it belongs
- if a change affects tests, CI, release flow, or security posture, mention it
- open with the answer, not with background
- do not explain basics the user did not ask for
- do not ask the model to expose hidden chain-of-thought; describe decisions and evidence instead
- keep one primary route and one output contract per answer

Default sections (enforced unless the contract specifies otherwise):

1. Summary
2. Assumptions
3. Recommendation
4. Implementation
5. Tests
6. Risks

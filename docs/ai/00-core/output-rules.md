# Output Rules

Use clean Markdown.

Rules:

- keep answers short unless the user asks for depth
- prefer compact sections over long prose
- avoid repeating project context that is already known
- distinguish facts from assumptions
- include trade-offs when recommending a direction
- if code is suggested, state where it belongs
- if a change affects tests or CI, mention it
- open with the answer, not with background
- do not explain basics the user did not ask for
- keep one primary route and one output contract per answer
- prefer this default concise output contract when no stricter route contract is required:
  1. Root cause
  2. Fix code
  3. Notes (optional)
- only use few-shot examples for repetitive generation tasks
- avoid full-project context dumps; use minimum sufficient relevant context

Default sections:

1. Summary
2. Assumptions
3. Recommendation
4. Implementation
5. Tests
6. Risks

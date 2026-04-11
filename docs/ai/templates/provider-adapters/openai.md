# OpenAI Adapter

Use when the serving stack supports OpenAI structured outputs or agentic tool orchestration.

- prefer the native structured output path with the contract-matched JSON schema rather than pasting raw schema text into the prompt
- keep system or developer instructions compact and stable for prompt caching
- pass dynamic user and repo context near the end
- do not request chain-of-thought; ask only for the contract artifact
- when a route depends on current external facts, keep source metadata explicit with dates and versions

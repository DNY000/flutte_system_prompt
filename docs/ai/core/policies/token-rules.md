# Token Rules

Reduce token usage by default.

Rules:

- keep the static prompt prefix stable and place dynamic request data near the end
- use the smallest rules variant that still preserves required safety and output quality
- load one task prompt, one output contract, and only the leaf guides that materially change the answer
- prefer zero-shot before adding examples
- use structured-output schemas or contract shells instead of long prose instructions
- retrieve through indexes first, then one or two leaf packs
- keep memory files short and durable; do not reload broad memory by default
- summarize large context before injecting it
- avoid copying raw logs, large tool outputs, or duplicated code into prompts
- when the serving stack supports prompt caching, keep invariant instructions and examples at the beginning

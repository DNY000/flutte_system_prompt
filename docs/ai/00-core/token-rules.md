# Token Rules

Reduce token usage by default.

Rules:

- load only the prompt files needed for the current task
- keep persistent context short and stable
- move long-lived decisions into memory files instead of repeating them
- prefer checklists to narrative text
- avoid duplicating code that already exists in the repository
- answer at the level requested by the user
- summarize first, expand only on demand

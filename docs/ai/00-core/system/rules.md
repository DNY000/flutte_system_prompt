# Prompt Runtime Rules (Full)

- stay within Dart/Flutter and prompt-system scope unless user requests otherwise
- use one primary route and one output contract per request
- load only required context; avoid context sprawl
- enforce contract section names exactly
- distinguish facts, assumptions, and recommendations
- apply risk-aware depth using `response-depth-policy.md`
- for review tasks: findings first by severity
- for high-risk tasks: include mitigation or rollback guidance
- prefer SDK and architecture stability over dependency churn
- write memory only for durable and approved knowledge
- prefer clean architecture, testability, maintainability, and explicit trade-offs
- do not propose code that breaks existing architectural boundaries without calling it out
- prefer secure defaults
- consider performance impact before recommending abstractions
- produce short, structured, actionable output
- be direct; do not start with generic theory
- do not mix design, audit, research, and implementation into one blurred answer
- when context is missing, ask for the minimum critical information or proceed with clearly labeled assumptions

## Automated Issue Synthesis
- **MANDATE**: When concluding a `debug-triage` or resolving a bug fix, you MUST generate a response formatted as `04-templates/resolved-issue-memory.md` to permanently record the fix.

## Security & Redaction (Anti-Secret Leaking)
- **SECURITY AUDITOR MANDATE**: Default action before logging, printing code to the console, or writing memory to `.md` files is to mask ALL high-entropy strings.
- Replace API Keys, JWT Tokens, Passwords, and Stripe Keys with `[REDACTED_SECRET]` to prevent credential leaks.

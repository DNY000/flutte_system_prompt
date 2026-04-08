# Glossary

Canonical terms used across prompt routes, outputs, and review artifacts.

## Prompt System Terms

- route_id: stable route key selected by router
- output_contract: strict response shape for a route
- task_prompt: specialist prompt file for one discipline
- required_context: minimum files needed for one answer
- prompt_package: assembled runtime artifact that contains route metadata, prompt layers, and user request
- route_manifest: machine-readable route table in `tools/prompt-cli/routes.json`
- guide_pack: retrieval-oriented reference pack loaded only when it materially changes the answer
- skill_precedence: ordering rule for project, global, and built-in skills
- review_gate: checkpoint before promotion or release

## Engineering Terms

- feature module: cohesive unit owning one user capability
- shared module: reusable module with explicit dependency boundaries
- use-case: business operation coordinating domain logic
- repository: abstraction over one or more data sources
- adapter: translation layer between external API and internal model

## Quality Terms

- regression: behavior that gets worse after a change
- release blocker: issue that must be fixed before shipping
- risk level: impact-severity estimate for requested work
- residual risk: accepted risk after mitigation

## Update Rules

- add only durable terms used repeatedly
- prefer one canonical term over many aliases
- remove ambiguous terms when they create routing confusion

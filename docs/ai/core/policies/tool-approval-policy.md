# Tool Approval Policy

Use this policy whenever a route touches tools, connectors, MCP servers, or external side effects.

## Approval Levels

- `read-only`: local file reads, route lookup, schema lookup, and passive metadata fetches
- `sensitive-read`: secrets, credentials, production logs, ticket systems, customer data, or protected MCP resources
- `side-effecting`: file writes, state changes, publishing, deployment, approvals, or data movement outside the local prompt package

## Approval Rules

- allow `read-only` actions by default when they stay within the current task scope
- require explicit user confirmation for `sensitive-read` access that exposes secrets, customer data, or privileged systems
- require explicit user confirmation outside model-only text for every `side-effecting` action
- do not treat prompt text as the source of authorization; enforce approval at the tool or runtime layer

## MCP And Connector Scope

- request the narrowest server, workspace root, and resource scope that can answer the task
- do not broaden MCP roots or connector scopes unless the user explicitly approves that expansion
- prefer allowlisted servers and typed resources over free-form connector browsing

## Auditability

- record the action category, target, and approval requirement in run artifacts when supported
- attach the reason for approval to release or deployment artifacts when the action changes external state

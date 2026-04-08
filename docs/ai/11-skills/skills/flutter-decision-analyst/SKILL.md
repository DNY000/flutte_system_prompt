# flutter-decision-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Trade-off matrices for Flutter engineering choices (widgets, state, packages).

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** compare go_router vs Navigator 2.0 for a deep-link-heavy app.

**Example comparison table:**
```text
Criteria          | go_router         | Navigator 2.0 manual
------------------|-------------------|----------------------
Deep-link support | built-in via URI  | manual RouteInformation
Redirect guards   | redirect callback | RouteInformationParser
Learning curve    | low               | high
Community recipes | many              | few
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: use `go_router` for new projects requiring deep links and route guards.
- `Context Signals`: deep-link requirement, team size < 5, web parity needed.
- `Option Matrix`: go_router (recommended) vs Navigator 2.0 manual (only if custom URL strategy required).
- `Recommendation`: adopt go_router; encapsulate route definitions in `lib/router/app_router.dart`.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`

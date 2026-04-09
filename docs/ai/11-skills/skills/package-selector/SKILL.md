# package-selector

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

SDK-first package choice, dependency governance, upgrade risk.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Dependency snippet** after selection (pin major versions in team policy):

```yaml
dependencies:
  dio: ^5.4.0
  flutter_secure_storage: ^9.2.0

dev_dependencies:
  build_runner: ^2.4.0
```

**Decision-matrix row:** choose `dio` over raw `HttpClient` when interceptors, cancellation, and consistent error mapping are required; confirm null-safety and Flutter SDK lower bound in `pubspec.yaml`.

## Anti-patterns

- Adding a plugin for one line of `MethodChannel` code without cost/benefit.
- Bumping major versions without reading changelogs for breaking API renames.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`

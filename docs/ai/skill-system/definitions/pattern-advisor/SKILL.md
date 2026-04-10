# pattern-advisor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Repository, use-case, adapter, mapper, facade, and strategy selection for Flutter apps.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Repository port + adapter** (Dart):

```dart
abstract class ProfileRepository {
  Future<Profile> fetch();
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._client);
  final ApiClient _client;

  @override
  Future<Profile> fetch() async {
    final dto = await _client.getProfile();
    return dto.toDomain();
  }
}
```

Use **strategy** when multiple algorithms are swappable (e.g. pricing rules); use **facade** when hiding a cluster of legacy APIs behind one call site.

## Anti-patterns

- “Repository” that returns `Map<String, dynamic>` to the UI.
- Strategy objects recreated every build — inject or cache at scope boundary.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Modeling: `docs/ai/guides/flutter/data-and-backend/modeling-and-mappers.md`

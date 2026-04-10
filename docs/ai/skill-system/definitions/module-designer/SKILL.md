# module-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Feature module boundaries, shared modules, and cross-feature dependency rules.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Module dependency diagram** (text):

```text
presentation -> application -> domain
data -> domain (implements repository ports)
presentation must not import data implementations directly
```

**Concrete rule:** `OrderRepository` interface lives in `domain/`; `OrderRepositoryImpl` + Dio live in `data/` and are bound at composition root.

## Anti-patterns

- Shared “utils” folder becoming a second domain layer with business rules.
- Importing another feature’s `presentation` from your feature’s `data` layer.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/guides/flutter/app-architecture/feature-model-organization.md`

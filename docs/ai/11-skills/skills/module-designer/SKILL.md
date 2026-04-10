# module-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Feature module boundaries, shared modules, and cross-feature dependency rules.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

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

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/app-architecture/feature-model-organization.md`

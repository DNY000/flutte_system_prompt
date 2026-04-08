# App Architecture Section Index

Use this section for project structure, module boundaries, dependency direction, and architectural abstractions.

Examples:

- `flutter/app-architecture/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `feature-and-module-boundaries` | feature-first, module ownership, shared code, internal packages | `flutter/app-architecture/feature-and-module-boundaries.md` |
| `layering-and-dependencies` | presentation, domain, data layering and dependency direction | `flutter/app-architecture/layering-and-dependencies.md` |
| `feature-model-organization` | location of DTOs, domain models, UI models, mappers, bridges, and shared infrastructure | `flutter/app-architecture/feature-model-organization.md` |
| `code-organization` | folder structure, class split, module ownership | `flutter/domains/code-organization.md` |
| `architecture-patterns` | repository, use case, adapter, mapper, facade, strategy | `flutter/domains/architecture-patterns.md` |

## Retrieval Rules

- start with `feature-and-module-boundaries` for structural questions
- add `layering-and-dependencies` when the decision is about coupling or dependency flow
- add `feature-model-organization` when the main issue is where models, mappers, and wrappers should live
- add `architecture-patterns` only when an abstraction choice is actually needed
- load `flutter/app-architecture/examples.md` when the user asks for architecture direction without enough current-state detail

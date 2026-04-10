# Feature Model Organization

## Use For

- deciding where DTOs, domain models, UI models, bridges, and package wrappers should live
- keeping feature ownership clear when the app grows
- preventing shared folders from becoming dumping grounds

## Default Decisions

- feature-first
  Keep most models and adapters inside the owning feature.
- shared core
  Reserve shared folders for proven cross-feature primitives, not speculative reuse.
- boundary-local mapping
  Keep mappers beside the boundary they protect.
- app-owned wrappers
  Keep package and platform wrappers close to the feature unless they are genuinely app-wide infrastructure.

## Decision Switches

- if a type is used by only one feature, keep it in that feature even if the name sounds generic
- if multiple features depend on the same concept but not the same presentation shape, share the domain model and keep separate UI models
- if the wrapper talks to one app-wide service such as auth session or analytics, move it to shared infrastructure
- if a folder named `common`, `helpers`, or `utils` starts attracting models from unrelated features, the structure is drifting

## Example Layout

```text
lib/
  features/
    profile/
      data/
        dtos/
        mappers/
        repositories/
      domain/
        models/
        repositories/
      presentation/
        models/
        controllers/
        widgets/
    payments/
      data/
        bridges/
        plugins/
      domain/
        models/
        services/
      presentation/
        models/
        screens/
  shared/
    core/
      network/
      session/
      logging/
    design_system/
```

Why:

- models stay near the feature and layer that owns them
- app-wide infrastructure is explicit instead of mixed into feature code

## Extraction Rules

- extract to `shared/core` only after the second real consumer appears
- keep package wrappers out of `shared` until multiple features truly depend on them
- promote a feature module into an internal package only when ownership and release cadence are already stable

## Anti-Patterns

- one giant `models/` folder at app root
- DTOs shared directly across unrelated features
- package wrappers imported from screens all over the codebase
- moving code to `shared` because reuse is hypothetical

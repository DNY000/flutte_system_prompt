# release-manager

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Release risk, rollout, rollback, store submission, and promotion gates.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Release checklist fragment:**

```text
Version: 1.5.0+300
Build: flutter build appbundle --flavor prod -t lib/main_prod.dart
Signing: upload key in CI secret store; no keys in repo
Rollout: 10% staged — monitor crash-free sessions and ANR rate
Rollback: prior artifact 1.4.9+299 tagged in store; hotfix branch procedure documented
```

## Anti-patterns

- Shipping without mapping native migrations (Android `targetSdk`, iOS privacy manifests).
- Skipping staged rollout when database migrations are irreversible.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/guides/flutter/deployment/flavors-signing-and-secrets.md`

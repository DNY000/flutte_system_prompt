# release-manager

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Release risk, rollout, rollback, store submission, and promotion gates.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

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

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/deployment/flavors-signing-and-secrets.md`

# multiplatform-strategist

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Flutter web/desktop only when tied to mobile product parity or shared codebase.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** plan how to support Flutter Web for the existing mobile app dashboard.

**Example capability parity matrix:**
```text
Feature          | Mobile | Web
-----------------|--------|----
Push notifications | ✅    | ⚠️ (limited, service worker)
File picker        | ✅    | ✅
Camera             | ✅    | ✅ (getUserMedia)
Secure storage     | ✅    | ❌ (use IndexedDB + encryption)
Deep links         | ✅    | ✅ (URL routing)
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: deliver Web as a progressive enhancement target with feature-flag guards for unsupported APIs.
- `Module Impact`: platform-channel calls wrapped behind abstract interfaces; web stubs injected via `kIsWeb`.
- `Migration Plan`: 1) audit all plugin usages for web support, 2) add conditional imports, 3) release web as beta behind feature flag.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`

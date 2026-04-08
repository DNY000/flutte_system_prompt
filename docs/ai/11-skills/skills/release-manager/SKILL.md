# release-manager

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Store rollout, rollback, promotion gates, mobile release readiness.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** assess release readiness for v2.4.0 targeting the Play Store production track.

**Example release gate checklist:**
```text
✅ All CI jobs green (build-android, build-ios, unit-tests)
✅ Golden test regressions: 0
✅ Crash-free sessions (last 7 days): 99.7%
⚠️ Open sev-2: checkout deep-link broken on Android 12 — hotfix in progress
❌ Store listing screenshots not updated for new onboarding flow
```

**Example expected output fragment (release readiness):**
- `Readiness`: NOT READY — 1 open sev-2 and store listing gap.
- `Rollback Strategy`: use Play Store rollout at 10%; halt and rollback via staged rollout control if crash rate > 0.5%.
- `Promotion Gate`: re-evaluate after hotfix merged and screenshots updated.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`

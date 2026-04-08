# source-validator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Rank and validate sources; separate facts from inference for research outputs.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** validate the source recommending `dio` v6.0 for Flutter HTTP before using it.

**Example source trust check:**
```text
Claim: "dio 6.0 is stable and production-ready for Flutter 3.22"
Source: pub.dev/packages/dio (official)
  - Latest version: 5.4.3 (as of 2024-06); v6.0 is not yet released
  - Flutter SDK constraint: >=3.0.0
Result: STALE — claimed version does not exist; recommend pinning to 5.4.x
```

**Example expected output fragment (source validation):**
- `Trust Rank`: pub.dev (primary) > blog post (secondary, may be outdated).
- `Stale Facts Flagged`: "dio v6.0" version claim unverifiable; latest is 5.4.3 on 2024-06.
- `Verified Facts`: dio 5.4.3 supports Flutter 3.x, null-safe, active maintenance.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`

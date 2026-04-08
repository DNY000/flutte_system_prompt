# Deployment Section Index

Use this section for CI validation, environment separation, signing, artifacts, and release rollout.

Examples:

- `flutter/deployment/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `ci-validation-and-caching` | PR validation, dependency caching, deterministic CI stages | `flutter/deployment/ci-validation-and-caching.md` |
| `flavors-signing-and-secrets` | flavors, bundle IDs, signing, protected secrets, environment split | `flutter/deployment/flavors-signing-and-secrets.md` |
| `release-artifacts-and-rollout` | artifact generation, symbol retention, changelog, rollout, rollback | `flutter/deployment/release-artifacts-and-rollout.md` |

## Retrieval Rules

- start with `ci-validation-and-caching` for build automation design
- add `flavors-signing-and-secrets` when environment or signing boundaries matter
- add `release-artifacts-and-rollout` when the problem is packaging, store delivery, or rollback
- load `flutter/deployment/examples.md` when the pipeline goal is broad and not yet split into validation, signing, or release stages

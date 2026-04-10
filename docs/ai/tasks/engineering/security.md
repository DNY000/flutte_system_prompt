# Security Task Prompt

## Purpose

Use this prompt for authentication, token handling, local storage, networking, logging, permissions, deep links, WebViews, sensitive data, release hardening, and security reviews.

## Default Routing

- route: `security-audit` or `security-implement`
- output contract: `review-report-v1` for audits
- output contract: `implementation-plan-v1` for fixes

## Required Input

- platforms: android, ios, web, desktop
- data sensitivity
- authentication flow
- storage locations
- network trust boundaries
- third-party SDKs
- compliance or privacy requirements

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-rules.md`, `docs/ai/core/policies/mcp-research-policy.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/context/project-context.md`
- Flutter security guides (choose only what matches the issue):
  - `docs/ai/guides/flutter/security/release-hardening-and-privacy.md`
  - `docs/ai/guides/flutter/security/file-input-and-upload-safety.md`
  - `docs/ai/guides/flutter/security/network-links-and-webview.md`

## Core Rules

- treat secrets, tokens, and personal data as high-risk by default
- never treat obfuscation as a substitute for secret protection
- avoid storing sensitive data unless there is a clear need
- prefer platform-backed secure mechanisms over custom security code
- keep Flutter SDK and package dependencies current enough to receive security fixes

## Mobile Security Baseline

- align reviews to OWASP MASVS categories: storage, auth, network, platform, code, resilience, and privacy
- secure local sensitive data with platform-backed secure storage where appropriate
- secure network traffic with TLS and validated endpoints
- consider certificate or identity pinning only for endpoints under your control and only when justified by the threat model
- use platform-provided authentication APIs for biometrics or device auth
- review IPC, deep links, intents, universal links, and app-to-app interactions carefully
- redact sensitive data from logs, analytics, crash reports, and notifications

## Flutter-Specific Guidance

- do not hard-code API keys, tokens, or private secrets into Dart or native source
- do not disable certificate validation, trust all certificates, or bypass hostname checks
- do not store auth tokens in plain preferences or insecure files
- do not expose debug endpoints, verbose logging, or insecure feature flags in release builds
- if using `--obfuscate`, state clearly that it only increases reverse-engineering cost and does not protect secrets

## Threat Review Angles

- data at rest
- data in transit
- authentication and re-authentication
- platform interaction and permission scope
- update hygiene for Flutter SDK and packages
- reverse engineering and tamper resistance only if the business case justifies it

## Anti-Patterns

- shipping secrets inside the client
- custom crypto or custom TLS handling without a strong reason
- using WebViews for sensitive auth flows without clear constraints
- storing user identifiers or tokens in logs
- broad platform permissions without a concrete feature need

## Steps

1. Confirm scope: platforms, auth model, and data classification (PII, secrets, payment, health).
2. Choose route behavior:
   - audit → `review-report-v1`
   - fix/implement → `implementation-plan-v1`
3. Identify trust boundaries:
   - data at rest (device storage, caches)
   - data in transit (TLS, endpoints, pinning decisions)
   - identity and session handling (tokens, refresh, re-auth)
4. List findings (severity-first) with evidence and the smallest safe mitigation.
5. Separate “must fix before release” from defense-in-depth.
6. If relying on external guidance (OWASP, platform changes), cite versions/dates per `mcp-research-policy.md`.

## Validation

- No recommendation should require embedding secrets in the client.
- Logging guidance must include redaction (tokens, identifiers).
- Storage guidance must explicitly avoid plain preferences for secrets.
- For fixes, specify verification: test, manual steps, or security checks.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “We store refresh token in SharedPreferences; move to secure storage; ensure logs don’t leak tokens.”

**Expected output fragment (`implementation-plan-v1`):**

- `Target Files`: token store wrapper; logout flow; analytics/logging wrapper.
- `Implementation Steps`: migrate token to secure storage; clear on logout; add redaction; add regression test.
- `Risks`: migration edge cases; token loss; plan rollback via feature flag.

## Output Behavior

- classify each issue by severity
- explain attacker impact, not only code smell
- separate immediate fixes from defense-in-depth improvements
- state what must be fixed before release

## Completion Checklist

- secrets are not embedded in the app
- sensitive data storage is justified and protected
- network traffic is validated and encrypted
- auth flows use secure platform or backend practices
- logging and analytics are redacted
- dependencies and Flutter SDK update risk are considered

# business-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

User flows, requirement clarification, and acceptance criteria before implementation.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**User story + acceptance criteria:**

- **Story:** As a user, I want to reset my password from the login screen so I can regain access without contacting support.
- **AC1:** Given an expired session, when the user taps “Forgot password”, they see email entry and a submit control.
- **AC2:** On successful request, show confirmation and throttle resend per rate-limit policy.
- **AC3:** Errors from the API surface a non-technical message and a retry when safe.

Map each AC to a **test layer** (widget vs integration) in the implementation plan.

## Anti-patterns

- Vague AC like “works on all devices” without specifying minimum OS versions already in `project-context`.
- Mixing legal/compliance requirements into UI stories without explicit review flag.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`

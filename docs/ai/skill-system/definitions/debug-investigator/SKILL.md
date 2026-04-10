# debug-investigator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Runtime failures, flaky tests, crashes, and ambiguous logs — form hypotheses and validation steps.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Stack excerpt** (sanitized):

```text
#0      State.setState (package:flutter/src/widgets/framework.dart:...)
#1      _LoginScreenState._onTap (package:myapp/features/auth/login_screen.dart:42)
```

**Hypothesis:** `setState` after dispose — `_onTap` not cancelled when route popped.

**Validation steps:**

1. Add `if (!mounted) return;` before async gap in `_onTap`.
2. Reproduce with slow network; confirm no setState after `dispose`.
3. Add widget test that pops route during in-flight login.

## Anti-patterns

- Changing random lines without repro steps or log line anchors.
- Ignoring platform-specific logs when the issue is iOS-only JNI/embedding.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/guides/flutter/testing-and-debugging/examples.md`

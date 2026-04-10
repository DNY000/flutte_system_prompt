# eval-designer

**Scope:** Prompt OS — benchmarks, graders, route tests, regression strategy.

## Goal

Design eval cases and harnesses so routing and output quality do not regress.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Route regression case** (conceptual):

```yaml
id: route-code-impl-001
input: "Add email validation to login_form.dart using the existing AppFormField"
expect:
  route_id: code
  output_contract: implementation-plan-v1
  must_mention:
    - "Target Files"
    - "Tests"
forbidden:
  - "rewrite entire app"
```

Pair with CLI / TS router tests under `tools/prompt-powershell` and `tools/prompt-runtime-typescript` as implemented in repo.

## Anti-patterns

- Evals that only check keywords without structure (contracts exist for a reason).
- Flaky cases tied to current date or random IDs without fixtures.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/guides/ai-systems/evals-and-regression.md`
- Task: `docs/ai/tasks/ai-systems/ai-evals.md`

# Hook Lifecycle

Hook points for workflow control and observability. Implementations may live in your host (CLI, IDE, CI); this repo documents **contracts**: when each hook runs, what to validate, and what to do on failure.

When the runtime supports structured outputs, hooks should preserve the selected contract and its matching schema from `docs/ai/core/contracts/structured-output-schemas.json`.

## Hook points

| Hook | When | Primary purpose |
| --- | --- | --- |
| `pre-route` | Before routing | Sanitize input; strip unsafe payloads; normalize encoding |
| `post-route` | After `route_id` resolved | Validate confidence; escalate `risk_level` if signals contradict low-risk route |
| `pre-execute` | Before model/tool work | Ensure required context files loaded; output contract id present |
| `post-execute` | After answer drafted | Quality checks; redaction; telemetry to `.promptos/` if enabled |
| `pre-release-gate` | Before ship | Run `validate-manifest`, evals, `prompt-release-checklist.md` |

Full ordering with skills: `../skill-execution-pipeline.md`.

---

## Per-hook: suggested inputs, constraints, steps

### `pre-route`

- **Inputs:** raw user text, session metadata, optional attachments list.
- **Constraints:** no execution of untrusted code; max length policy if configured.
- **Steps:** trim; reject empty; classify multimodal pointers; log correlation id.
- **On failure:** return structured error; do not route.

### `post-route`

- **Inputs:** `route_id`, `risk_level`, matched pattern, query signals.
- **Constraints:** if query mentions payments, PII, or native bridges, floor `risk_level` to at least `medium` unless task says otherwise.
- **Steps:** compare route to keyword signals; if mismatch, either re-prompt for clarification or set `needs_clarification` flag in run metadata.
- **On failure:** prefer clarification over wrong high-stakes route.

### `pre-execute`

- **Inputs:** resolved route, loaded file list, `output_contract` id.
- **Constraints:** exactly one task prompt from `tasks/`; core rules present.
- **Steps:** verify `project-context` not placeholder-only for production routes; verify guide index consulted before deep API advice for Flutter.
- **On failure:** block execution; load missing layer.

### `post-execute`

- **Inputs:** draft answer, contract id, rubric optional.
- **Steps:** check PII patterns in logs; ensure answer sections match contract shell from `templates/contract-shells.md` when required.
- **On failure:** strip sensitive lines; re-run grader if eval mode.

### `pre-release-gate`

- **Inputs:** branch, version, changelog pointer.
- **Steps:** `npm run validate-manifest` in `tools/prompt-runtime-typescript`; `run-evals.ps1` if routing changed; human checklist from `core/policies/prompt-release-checklist.md`.
- **On failure:** no release tag.

---

## Example: post-route risk bump

```text
Query contains: "store refresh token", "SharedPreferences"
Resolved route: code (implementation)
Action: set risk_level = high; ensure security-auditor or security task consulted before suggesting storage code
```

---

## References

- Pipeline: `../skill-execution-pipeline.md`
- Plugin schema (hook enum): `../plugins/plugin-schema.json`
- Operating model: `../../core/system/operating-model.md`

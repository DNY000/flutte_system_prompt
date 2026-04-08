# Incident To Memory Loop

Turn repeated failures into durable memory and guardrails.

## Trigger Conditions

- production incident affecting critical flow
- same defect pattern appears more than once
- release rollback caused by known class of failure

## Workflow

1. capture incident summary and evidence
2. classify root cause category
3. map to memory target:
   - `mistakes.md` for repeated failures
   - `patterns.md` for reusable fixes
   - `decisions.md` for policy-level changes
4. add or update guardrail in task prompt or core policy
5. add eval case if routing or output quality contributed
6. review and approve memory update

## Required Fields

- incident id:
- date:
- impacted route family:
- root cause:
- prevention action:
- memory file updated:
- eval case added:

## Exit Criteria

- memory entry approved
- corresponding policy or prompt updated
- at least one regression case added when applicable

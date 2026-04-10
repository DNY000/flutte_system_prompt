## Summary
Close the generated-output verification gap before expanding more routes.

## Current State
The prompt system validates routing, contract mappings, and manifest integrity but not final answer artifacts.

## Gaps
- No automated check for top-level contract sections in generated outputs.
- No regression fixtures proving pass and fail behavior for output artifacts.

## Iterations
1. Add a deterministic artifact verifier for generated answers.
2. Add fixture-based regression coverage for pass and fail cases.
3. Wire the verifier into local eval commands and CI.

## Task Backlog
- Implement contract-aware artifact verification
- Add artifact regression fixtures
- Update release and getting-started docs

## Review Gates
- Artifact regression suite passes
- Existing route and contract evals remain green
- Docs mention the new verification command

## Risks
- Structural verification alone does not replace human review of answer quality.

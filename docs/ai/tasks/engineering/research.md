# Research Task Prompt

## Purpose

Use this prompt when the answer depends on current external documentation, package versions, standards, security guidance, or platform behavior.

## Default Routing

- route: `research-brief`
- output contract: `research-brief-v1`

## Required Input

- exact research question
- decision that depends on the answer
- platforms in scope
- acceptable trade-offs
- comparison criteria

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/policies/mcp-research-policy.md`, `docs/ai/core/contracts/output-rules.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/context/project-context.md`
- If the research is about prompt OS behavior: `docs/ai/core/policies/answer-policies.md`, `docs/ai/core/contracts/output-contracts.md`

## Source Policy

- prioritize official docs and primary sources
- for Flutter and Dart, prefer `docs.flutter.dev`, `api.flutter.dev`, and `dart.dev`
- for mobile security, prefer OWASP MASVS and related OWASP mobile references
- for CI/CD platform behavior, prefer official vendor documentation
- use community content only as a fallback or supporting signal

## Core Rules

- state exact versions, dates, and platform assumptions
- separate facts from inferences
- compare options using the same criteria
- do not recommend a package or tool without stating maintenance and integration cost
- summarize first, then recommend

## Flutter And Dart Research Rules

- prefer guidance that matches the current stable ecosystem
- check whether architecture, performance, or testing guidance is official or only community opinion
- distinguish framework rules from package-specific advice
- call out when a package adds lock-in, native complexity, or maintenance burden

## Anti-Patterns

- answering version-sensitive questions from memory only
- mixing outdated and current guidance
- recommending packages with no maintenance or poor fit without stating the risk
- presenting inference as fact

## Steps

1. Restate the research question and the downstream decision it supports.
2. Define criteria (what “better” means) and constraints (platforms, SDK bounds, compliance).
3. Collect sources in the default order (local → MCP → official → primary → secondary) per `mcp-research-policy.md`.
4. Extract **facts** with citations (version/date) and list **unknowns** explicitly.
5. Compare options using a consistent table and produce a decision-oriented conclusion.
6. If the conclusion will matter again, propose a memory entry (`memory-curator`) after it’s validated in real work.

## Validation

- Every external-facing claim that affects correctness must have a source and “as of” date/version.
- Facts vs inferences are separated.
- Recommendation ties directly to the decision, not to generic best practices.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Is `go_router` the best choice for guarded routes in Flutter in 2026? What are the risks vs Navigator 2.0 direct?”

**Expected output fragment (`research-brief-v1`):**

- `Findings`: go_router version X supports redirects; official docs show pattern; risks include migration cost and deep-link edge cases.
- `Conclusion`: choose go_router if guarded nested routing + deep links are core; otherwise keep Navigator with a thin routing layer.

## Output Behavior

- keep the question narrow
- cite sources clearly
- produce a decision-oriented conclusion, not a literature dump
- state what remains uncertain

## Completion Checklist

- official sources are used first
- facts and inferences are separated
- versions and dates are stated
- recommendation is tied to the actual decision

# AI MCP Workflow Task Prompt

## Purpose

Use this prompt for Flutter and Dart AI workflow decisions involving editor rules files, compact rule variants, MCP server setup, and tool-assisted debugging or package research.

## Default Routing

- route: `ai-mcp-workflow`
- output contract: `decision-matrix-v1`

## Required Input

- target editor, agent, or tool surface
- current workflow pain points
- live data or documentation sources needed
- security and connector boundaries
- desired level of automation vs manual review

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/policies/mcp-research-policy.md`, `docs/ai/00-core/contracts/output-rules.md`
- Task: this file
- AI systems guides:
  - `docs/ai/08-guides/ai-systems/context-memory-and-mcp.md`
  - `docs/ai/08-guides/ai-systems/evals-and-regression.md` (when automation/evals are requested)
- Flutter AI workflow guides (when Flutter/Dart specific):
  - `docs/ai/08-guides/flutter/ai-and-mcp/index.md`
  - `docs/ai/08-guides/flutter/ai-and-mcp/ai-rules-and-editor-workflows.md`

## Core Rules

- keep stable project guidance in local rules files, not only in chat history
- use MCP for live, structured, or repeat lookup data instead of copy-pasting stale context
- keep connector scope minimal and explicit
- separate setup facts from workflow recommendation
- prefer official Flutter, Dart, and tool docs for version-sensitive guidance

## Flutter-Specific Guidance

- treat AI rules files and compact rule variants as a local prompt surface
- use Dart or Flutter MCP guidance when the workflow depends on package search, docs lookup, or structured tooling data
- define when debugging should stay local vs when MCP-assisted docs or telemetry lookup is worth the cost
- define how package research, error triage, and release-note checks fit into the workflow

## Steps

1. Identify the surface:
   - IDE rules files, CLI routing, TS runtime, or a hosted agent
2. Decide what must be **local** vs **live**:
   - local: stable policies, folder standards, output contracts
   - live: package versions, release notes, repo state, runtime logs
3. Define connector boundaries (MCP):
   - what data is allowed (repo files, docs, issue trackers)
   - what data is forbidden (secrets, production PII)
4. Choose one baseline workflow and keep it minimal:
   - route → context load → execute → verify → memory (only when durable)
5. Add automation only where regressions are costly:
   - route regression
   - contract compliance
   - rubric grading for release gate

## Validation

- Ensure the workflow includes a verification step (tests/evals/rubric) rather than “trust the model”.
- Ensure source order and version/date rules are applied for research (`mcp-research-policy.md`).
- Ensure the proposed setup does not expand connector scope beyond the stated need.

## Example

**Example request:** “We keep getting stale package advice in chat. Add a workflow so research always checks current pub.dev versions and records durable conclusions.”

**Expected output fragment (`decision-matrix-v1`):**

- `Decision`: keep stable rules in repo; use MCP/external research only when version-sensitive; require `source-validator` output table for package advice.
- `Implementation Notes`: add a `research` task route usage pattern; persist run metadata to `.promptos/` and promote validated outcomes via `memory-curator`.
- `Risks`: connector overreach; mitigate with narrow tool scopes and redaction.

## Output Behavior

- choose one baseline workflow
- compare only realistic alternatives
- include concrete implementation notes for rules files, MCP usage boundaries, and validation checks
- include risks such as stale context, connector overreach, and workflow complexity

## Completion Checklist

- workflow baseline is explicit
- MCP vs local-rules boundary is explicit
- live-data and research triggers are named
- security and maintenance risks are called out

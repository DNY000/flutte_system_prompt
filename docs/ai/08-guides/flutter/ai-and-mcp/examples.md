# AI And MCP Section Examples

Use these examples to recognize Flutter AI workflow and MCP decisions.

## Example 1: Rules Files Or Chat History

Context:

- team keeps restating Flutter architecture boundaries in every AI session
- answers drift across editors

Default decision:

- move durable guidance into checked-in rules files and keep chat prompts thinner

Why:

- stable rules should be versioned and reusable

Switch:

- if the rule is temporary or experiment-specific, keep it local to the current task prompt

## Example 2: Should We Add MCP

Context:

- team repeatedly checks current package versions, release notes, and official docs
- copied context goes stale quickly

Default decision:

- add a narrow MCP workflow for live docs and package metadata

Why:

- this is a repeat live-data problem, not a missing static rule

Switch:

- if the work is mostly project-local and static, local docs remain cheaper

## Example 3: Debugging With Tool Assistance

Context:

- a plugin crash appears after an upgrade
- local logs suggest multiple possible causes

Default decision:

- reproduce locally first, then use MCP or research to confirm current migration notes and plugin behavior

Why:

- tool assistance should validate a narrowed hypothesis, not replace triage

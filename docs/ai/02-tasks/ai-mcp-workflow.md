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

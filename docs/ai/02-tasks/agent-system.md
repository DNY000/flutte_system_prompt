# Agent System Task Prompt

## Purpose

Use this prompt for AI agent architecture, specialist roles, tool boundaries, MCP usage, multi-agent splits, handoff design, and traceability.

## Default Routing

- route: `agent-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- task categories
- available tools or connectors
- latency constraints
- quality expectations
- current bottlenecks
- traceability needs

## Core Rules

- start with one strong main agent
- split into specialists only when the boundary is real
- define ownership for every agent
- do not create agents that duplicate the same decision space
- keep final output aggregation centralized

## Orchestration Rules

- separate research, design, implementation, and verification only when they can run independently
- define explicit handoff conditions
- define tool ownership by agent role
- keep MCP access intentional, not global by default
- build traces and evals into the design from the start

## Output Behavior

- show recommended agent topology
- define each agent's responsibility
- state what should remain single-agent
- include failure modes and verification gates

## Completion Checklist

- agent boundaries are clear
- handoffs are explicit
- tool ownership is explicit
- eval and trace plan exists
- multi-agent overhead is justified

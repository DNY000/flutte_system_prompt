# Prompt System Task Prompt

## Purpose

Use this prompt for prompt architecture, prompt optimization, output-contract design, token reduction, prompt versioning, and long-term prompt-system maintenance.

## Default Routing

- route: `prompt-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- current prompt structure
- main task categories
- repeated failure patterns
- context sources
- token constraints
- evaluation tolerance

## Core Rules

- do not solve prompt sprawl by adding more text blindly
- fix routing, layering, and contracts before adding more examples
- tie prompt changes to measurable failure modes
- keep stable context separate from request-specific details

## Optimization Rules

- define system, task, context, memory, and output layers explicitly
- keep each prompt file single-purpose
- use examples only where they increase recognition or reliability materially
- version prompts and compare them through evals
- prefer retrieval fixes before instruction bloat

## Output Behavior

- describe current state first
- identify the highest-value prompt changes
- sequence the work into iterations
- include review gates and regression strategy

## Completion Checklist

- prompt layers are explicit
- contracts are consistent
- token discipline exists
- eval strategy exists
- memory and MCP boundaries are clear

# AI Evals Task Prompt

## Purpose

Use this prompt for prompt evals, route regression tests, benchmark dataset design, grader strategy, trace grading, and prompt release gates.

## Default Routing

- route: `eval-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- target workflows
- common failure types
- current routes or prompts
- dataset sources
- acceptable regression tolerance
- publishing workflow

## Core Rules

- do not optimize prompts without a measurable baseline
- separate route accuracy from answer quality
- grade one property per evaluator when possible
- store benchmark examples that reflect real team queries
- re-run evals after every meaningful prompt or route change

## Evaluation Rules

- keep a route-resolution benchmark
- keep output-contract compliance checks
- keep a representative task-quality dataset
- use trace grading for multi-agent workflows
- track regressions before publishing prompt changes

## Output Behavior

- define the eval layers clearly
- propose datasets, graders, and release gates
- identify the smallest useful benchmark first
- include the rollout sequence

## Completion Checklist

- benchmark set exists
- route tests exist
- contract checks exist
- grader strategy exists
- release gates exist

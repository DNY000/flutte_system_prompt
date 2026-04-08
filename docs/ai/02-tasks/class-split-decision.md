# Class Split Decision Prompt

## Purpose

Use this prompt when the user asks whether a widget, controller, service, repository, or model should be split into multiple classes or files.

## Default Routing

- route: `class-split-decision`
- output contract: `decision-matrix-v1`

## Required Input

- current class responsibility
- dependencies
- lifecycle concerns
- test pain
- file size and change frequency
- number of state owners

## Split Rules

- split when a class has more than one reason to change
- split when UI layout, state orchestration, and side effects live together
- split when one class owns multiple external dependencies with unrelated purposes
- split when tests require excessive setup because responsibilities are mixed
- do not split purely to satisfy an arbitrary line count

## Flutter-Specific Heuristics

- extract widgets when state boundaries or rebuild boundaries are different
- extract view-model or controller logic when widget tests become too fragile
- extract mappers when DTO, domain, and UI model concerns are mixed
- extract adapters when plugins or platform APIs leak into feature logic

## Anti-Patterns

- splitting one readable class into many tiny files with no ownership clarity
- extracting helper classes that only forward one call
- splitting widgets without improving rebuild boundaries or readability
- creating a service class only to hide global mutable state

## Output Behavior

- answer `keep as is`, `split now`, or `split later`
- specify the split boundary
- state what each resulting class should own

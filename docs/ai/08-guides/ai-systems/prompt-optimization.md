# Prompt Optimization Pack

## Use For

- prompt architecture
- system vs task vs context separation
- token reduction
- prompt versioning
- prompt variable strategy
- output contract design

## Default Decisions

- prefer a layered prompt system over one giant prompt
- keep stable rules in the system layer and volatile task details in task or request layers
- use explicit output contracts instead of loose prose requirements
- optimize prompts with evals and datasets, not intuition alone
- add examples only when ambiguity materially hurts output quality

## Decision Switches

- if the same instruction repeats across many tasks, move it upward into system or task prompts
- if the prompt keeps growing because context is unstable, fix retrieval before rewriting instructions
- if prompt changes are not measurable, build evals before further optimization
- if a prompt is expensive but stable, consider prompt caching and compact variants

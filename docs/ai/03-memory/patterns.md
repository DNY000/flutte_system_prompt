# Patterns

Approved reusable patterns for the prompt operating system.

## Active Patterns

### Layered Prompt Package

- name: layered prompt package
- use when: assembling prompts for any routed task or building integrations for external tools
- avoid when: the target workflow is a tiny one-off experiment and no routing or contract enforcement is needed
- example: `Runtime -> System Prompt -> Output Rules -> Project Context -> Route Context -> Task Prompt -> Output Contract -> Output Shell -> User Request -> Final Instruction`

### Route-First Task Isolation

- name: route-first task isolation
- use when: a request clearly belongs to one task family such as design, architecture, review, or prompt-system maintenance
- avoid when: the request truly needs staged follow-up work instead of one immediate answer
- example: use `prompt-system-roadmap` for prompt architecture questions instead of mixing it with implementation or review routes

### Guide-Pack Retrieval

- name: guide-pack retrieval
- use when: a route benefits from Flutter domain guidance or AI-system reference packs
- avoid when: the answer can be produced from core rules and one task prompt alone
- example: decision routes load `08-guides/flutter/index.md` plus one or two leaf packs rather than the entire guide tree

### Skill Precedence

- name: project-global-built-in precedence
- use when: skill activation includes project-local overrides or organization-level additions
- avoid when: authors try to duplicate built-in route skills manually
- example: `project skills -> global skills -> built-in route skills`, keeping first occurrence only

### Eval-Before-Publish

- name: eval-before-publish
- use when: route patterns, output contracts, runtime behavior, or prompt structure changes materially
- avoid when: editing only explanatory prose that does not affect runtime behavior
- example: after updating a route family, run prompt evals and manifest validation before release

## Update Rules

- keep only patterns that recur across multiple tasks or releases
- remove patterns that become rules in `00-core/` if duplication starts to grow
- prefer concrete examples over abstract naming when the pattern is easy to misapply

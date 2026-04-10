# Folder Standards

This document defines the standard folder split for the prompt operating system.

## Design Principles

- one folder, one responsibility
- stable rules stay high in the tree
- route-specific behavior stays close to task prompts
- reusable knowledge stays separate from request-time context
- templates should mirror the live runtime, not an aspirational structure

## Canonical Folder Split

| Folder | Owns | Must Not Own |
| --- | --- | --- |
| `core/` | Global rules, routing rules, contracts, loading rules, governance | Route-specific advice, large examples, temporary notes |
| `context/` | Stable project facts and constraints | Per-request details, volatile release notes |
| `tasks/` | One task prompt per route family | Global rules duplicated from `core/` |
| `memory/` | Durable reusable knowledge | Temporary debugging notes or raw transcripts |
| `templates/` | Reusable shells and package templates | Route policy or project-specific facts |
| `indexes/` | Discovery aids and query examples | Normative runtime rules |
| `examples/` | End-to-end examples | Canonical rules that the runtime depends on |
| `references/` | Source maps and references | Runtime-specific decisions |
| `guides/` | Retrieval packs and decision handbooks | Global routing policy |
| `roadmap/` | Planned improvement work | Live runtime decisions that are already adopted |
| `releases/` | Release baselines and changelog | Working notes |
| `skill-system/` | Skill definitions, commands, and role profiles | Route manifest data |

## Repo-Root Supporting Folders

| Folder | Role |
| --- | --- |
| `agent/` | Flat index into skills and orchestration entry points |
| `tools/prompt-powershell/` | PowerShell runtime, route manifest, domain manifest, evals |
| `tools/prompt-runtime-typescript/` | Cross-platform runtime, tests, manifest validation |
| `.promptos/` | Runtime state and planning artifacts |
| `missions/` | Example mission payloads |
| `playground/` | Experiments and scratch assets |

## Naming Rules

- use lowercase kebab-case file names
- keep file names aligned to route ids or topic ids
- keep one major purpose per file
- avoid generic names like `notes.md` or `misc.md`

## Authoring Rules By Folder

### `core/`

- keep guidance stable and compact
- write rules that apply across many routes
- document the actual runtime behavior, not only the ideal behavior

### `context/`

- store facts that change slowly
- keep placeholders explicit when the project is not yet filled in
- avoid duplicating memory entries

### `tasks/`

- define route purpose, required input, core rules, and output behavior
- keep each prompt tied to one route family
- reference contracts explicitly

### `memory/`

- store durable decisions, patterns, mistakes, modules, and glossary entries
- summarize before adding more content
- remove duplicate or stale entries during maintenance

### `templates/`

- mirror the live prompt-package structure
- keep templates copyable into other tools
- update templates whenever runtime assembly changes
- keep structured outputs aligned with `core/contracts/structured-output-schemas.json` when the runtime supports them

## Refactor Rules

Move content upward when:

- the same instruction repeats in many task prompts
- the rule is stable across route families

Move content downward when:

- the rule only applies to one route family
- the rule depends on one narrow domain pack

Move content into guides or memory when:

- the content is reference material, not an instruction
- the content is durable knowledge, not a runtime rule

## Validation Expectations

After structural changes:

1. run route and contract evals
2. run manifest validation
3. spot-check one prompt package for the changed route family
4. update templates if runtime assembly changed

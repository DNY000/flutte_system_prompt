# Modules

Persistent map of repository modules and ownership boundaries for the prompt operating system.

## Active Modules

### Canonical Prompt Assets

- module_name: `docs/ai/`
- business_goal: own the canonical rules, prompts, templates, guides, memory, and release governance for the system
- owned_features: core rules, task prompts, templates, guides, references, memory, roadmap, release notes
- inbound_dependencies: prompt authors, CLI builder, TypeScript runtime, reviewers, CI validation
- outbound_dependencies: none at runtime; this module is consumed by the tooling layers
- data_sources: markdown assets under `docs/ai/`
- critical_flows: route-context lookup, contract lookup, task-prompt selection, prompt-package assembly content
- test_focus: path validity, route-to-prompt coverage, doc consistency with manifest and contracts
- release_risk: high

### PowerShell CLI Runtime

- module_name: `tools/prompt-cli/`
- business_goal: provide route resolution, prompt-package assembly, and eval execution for local operator workflows
- owned_features: `aiprompt.ps1`, `routes.json`, `flutter-domains.json`, eval scripts and datasets
- inbound_dependencies: repo root `aiprompt.ps1`, maintainers, CI jobs
- outbound_dependencies: canonical docs in `docs/ai/`
- data_sources: route manifest, domain manifest, eval datasets, docs tree
- critical_flows: query normalization, route resolution, prompt package build, prompt eval execution
- test_focus: route scoring parity, prompt package integrity, eval stability
- release_risk: high

### TypeScript Runtime

- module_name: `tools/prompt-runtime-ts/`
- business_goal: provide a cross-platform runtime with router parity, command-aware hints, and manifest validation
- owned_features: TypeScript router, command policies, skill precedence logic, validation tooling, tests
- inbound_dependencies: operators on non-PowerShell environments, CI validation
- outbound_dependencies: `tools/prompt-cli/routes.json`, canonical docs in `docs/ai/`
- data_sources: route manifest and runtime docs
- critical_flows: route resolution, top-candidate explanation, command alignment hints, manifest validation
- test_focus: scoring behavior, tie handling, skill ordering, manifest sync
- release_risk: high

### Agent And Skill Index

- module_name: `agent/` and `docs/ai/11-skills/`
- business_goal: define skill identities, command semantics, and agent role profiles used by operators and runtimes
- owned_features: skill index, skill packs, command mapping, role profiles, plugin and hook contracts
- inbound_dependencies: route manifest, prompt authors, runtime integrators
- outbound_dependencies: canonical core rules and task prompts
- data_sources: `agent/SKILLS.md` and `docs/ai/11-skills/`
- critical_flows: skill discovery, operator onboarding, route-to-skill alignment
- test_focus: skill naming consistency, path integrity, precedence documentation
- release_risk: medium

### Runtime State

- module_name: `.promptos/`
- business_goal: store operational state that should not live inside prompt definitions
- owned_features: plans, runs, logs, metrics, pending memory drafts
- inbound_dependencies: runtime operators and planning workflows
- outbound_dependencies: none; it should not become a source of canonical prompt policy
- data_sources: execution artifacts and workflow records
- critical_flows: plan persistence, run tracking, memory proposal staging
- test_focus: scope boundaries and cleanup discipline
- release_risk: medium

## Boundary Rules

- canonical prompt content belongs in `docs/ai/`, not `.promptos/`
- route metadata belongs in `tools/prompt-cli/routes.json`, not scattered across docs
- runtimes consume canonical docs but must not fork policy silently
- agent indexes should point to definitions instead of duplicating large prompt bodies

## Update Rules

- update module boundaries when ownership or runtime responsibilities change
- add new modules only when they own a distinct runtime or authoring concern
- mark deprecated modules with migration notes rather than silently removing history

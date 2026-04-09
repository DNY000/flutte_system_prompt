# Skill authoring guide (context, constraints, steps)

This repository keeps **executable skill definitions** under `docs/ai/11-skills/skills/<skill_id>/SKILL.md`, registered in `docs/ai/00-core/skill-registry.md` and wired per route in `tools/prompt-cli/routes.json`. This page defines **how full** a skill should be so agents get **enough context, constraints, and ordered steps** without wasting the context window.

## External references (how the industry structures skills)

These sources agree on a small set of ideas; we align locally without copying their tooling verbatim:

| Idea | Source |
| --- | --- |
| YAML `name` / `description` for discovery; body as instructions; optional `scripts/` / `references/` | [Agent Skills specification](https://agentskills.io/specification) |
| Concise body, concrete examples, workflows with clear steps, validation loops | [Anthropic — Skill authoring best practices](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/best-practices) |
| Ground skills in real tasks; refine with evals; progressive disclosure for large material | [agentskills.io — Best practices for skill creators](https://agentskills.io/skill-creation/best-practices.md) |
| Description tuned for **activation** (when to load); avoid vague generic procedures | [Optimizing skill descriptions](https://agentskills.io/skill-creation/optimizing-descriptions) |

**Context budget (rule of thumb):** keep each `SKILL.md` **under ~500 lines**; move long tables, API dumps, or extra scenarios to sibling files `references.md` or `examples.md` in the same folder and **point to them with “load when …”** conditions (progressive disclosure).

---

## What “enough” means in this repo

Every skill should make the following explicit **when they apply to that skill**:

### 1. Context (what the agent must assume or load)

- **Scope line** at top: domain (e.g. Flutter mobile only) and **non-goals** (e.g. not backend schema design).
- **Inputs:** route id, user goal, files mentioned, constraints from `01-context/project-context.md`.
- **Which guides to open:** at least one pointer into `docs/ai/08-guides/...` for Flutter work; for prompt-OS skills, pointers to `00-core/` or `08-guides/ai-systems/`.
- **Memory:** when to propose updates (`memory-curator`) vs read-only.

### 2. Constraints (hard rules)

- **Safety:** no secrets in output; follow `mcp-research-policy.md` for sources.
- **Architecture:** dependency direction (e.g. presentation → application → domain) when the skill touches layers.
- **Output:** single **output contract** id from `output-contracts.md` for the route family.

### 3. Steps (ordered workflow)

Use a **numbered list** for the default path, for example:

1. Confirm `route_id` and risk level.
2. Load minimal context per `context-loading-rules.md`.
3. Produce hypothesis / plan / code per contract.
4. Self-check against `quality_checks` in `skill-contracts.md`.
5. If verification fails: narrow scope, add tests, or escalate risk.

### 4. Validation loop (feedback)

Where quality matters, add: **run check → fix → repeat** (analyzer, tests, rubric, route eval).

### 5. Examples + anti-patterns

- **Example:** one concrete fragment (Dart, YAML, JSON, or markdown table) **grounded in this stack**.
- **Anti-patterns:** short list of failures (avoids repeated mistakes).

---

## Standard `SKILL.md` section order (recommended)

Order helps models that exhibit **primacy/recency** effects: put routing and goal first; put guardrails and handoff last.

1. Title + **Scope**
2. **Goal**
3. **When to activate** (optional if obvious from registry)
4. **Input** / **Output**
5. **Operational steps** (numbered)
6. **Constraints** (bullets) — or merge into steps if short
7. **Example**
8. **Anti-patterns**
9. **References** (links to registry, contracts, guides)

Optional sibling files (same directory):

- `references.md` — long checklists, version matrices
- `examples.md` — more scenarios
- `tests.md` — eval phrases or assertions for this skill

---

## Alignment with route + CLI

- **Source of truth for which skills run:** `tools/prompt-cli/routes.json` field `skills`.
- **Precedence:** `docs/ai/00-core/skill-precedence-policy.md` (project > global > built-in).
- **Contracts:** `docs/ai/00-core/skill-contracts.md` — each skill should map to contract shape where listed.

When you add a skill:

1. Add `SKILL.md` under `skills/<skill_id>/`.
2. Register in `skill-registry.md`.
3. Attach to routes in `routes.json` (and TS parity if required by your workflow).
4. Add or extend eval cases under `tools/prompt-cli/evals/` where routing quality depends on it.

---

## Authoring checklist (before merge)

- [ ] Scope and non-goals are one glance away at the top.
- [ ] Numbered **steps** cover the happy path and mention **verification**.
- [ ] **Constraints** include safety and output-contract expectations.
- [ ] At least one **concrete example** (code or structured artifact).
- [ ] **Anti-patterns** block common regressions.
- [ ] References use **repo-relative paths** under `docs/ai/`.
- [ ] Large material is **split** to `references.md` / `examples.md` with load-when rules.
- [ ] No time-sensitive claims without “verify on pub.dev / as of date” for packages.

---

## Optional: YAML frontmatter (interoperability)

Some hosts expect:

```yaml
---
name: widget-selector
description: Use when choosing layout, scroll, and Flutter widget primitives for mobile UI.
---
```

This repo’s skills are valid as **Markdown-first**; adding frontmatter is optional and should not duplicate the title. If you add it, keep `description` under ~1024 characters and list **when** to activate.

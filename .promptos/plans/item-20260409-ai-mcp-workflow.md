# Item completion plan: ai mcp workflow

> Use this file before implementation or before merge. Default scope: Flutter / mobile (`../SCOPE.md`).

## Metadata

| Field | Value |
| --- | --- |
| **item_id** | item-20260409-ai-mcp-workflow |
| **owner** | Codex |
| **status** | completed |
| **risk_level** | medium |
| **primary_route_id** | ai-mcp-workflow |
| **output_contract** | decision-matrix-v1 |

## 1. Problem & goal

- **Problem to solve:** The system has generic MCP policy but no first-class Flutter AI and MCP route, task prompt, or guide section for editor rules, MCP server usage, and tool-assisted debugging or package research.
- **Expected outcome (one sentence):** Add an `ai-mcp-workflow` route with supporting Flutter guide packs, skill references, and discovery docs.
- **Non-mobile / out of scope:** implementing a real MCP server or changing runtime connectors

## 2. Prerequisites

- **Docs / policy:** `docs/ai/02-tasks/`, `docs/ai/08-guides/flutter/`, `docs/ai/00-core/`
- **Tools:** routing docs, eval suites, manifest validation
- **Access:** repo write access only
- **People / team dependencies:** none

## 3. How (execution steps - ordered)

1. Add the `ai-mcp-workflow` task prompt and Flutter AI/MCP guide section.
2. Add route wiring in `routes.json`, routing docs, output contract mapping, and query index.
3. Update relevant skills and examples so the new capability is discoverable.
4. Run validation and update this task record.

## 4. Flutter / mobile impact

- **Screens / modules:** `none`
- **Native / plugin:** none
- **Build / store / CI:** yes; route and eval data must remain green
- **Performance / memory / jank:** no runtime impact

## 5. Definition of done

- [x] Code / docs / config updated within scope
- [x] No open TODOs left inside this item's scope
- [x] Eval / checklist items under Verify are passing
- [x] Memory / changelog (if needed) has owner and reviewer

## 6. Verify

- [x] `../checklists/pre-completion-checklist.md` completed
- [x] `run-evals` / CI (if routes or contracts changed)
- [x] Manual mobile checks (if UI / plugin / release): docs-only change, no runtime mobile verification needed

## 7. Risk & rollback

- **Remaining risk:** The new capability will still be guide-driven and not a real MCP runtime implementation.
- **Rollback:** remove the route, task prompt, guide section, and related references

## 8. After completion

- [ ] Run snapshot (if any): `none`
- [ ] Memory draft (if needed): `none`
- [ ] Weekly metrics (if you track): `none`

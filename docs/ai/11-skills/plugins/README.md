# Plugins

This folder defines extension points for runtime plugins. Plugins **extend** behavior; they do not replace routing, skills, or output contracts.

## Required plugin files

| Artifact | Role |
| --- | --- |
| `plugin.json` | Metadata: `id`, `version`, `description`, `hookPoints` (see `plugin-schema.json`) |
| Optional `README.md` | Human-facing behavior and failure modes |

Physical location of a plugin package is workspace-specific; the **schema** in this repo is canonical.

---

## Constraints (non-negotiable)

- Plugins **must not** bypass output-contract enforcement (`00-core/output-contracts.md`).
- Plugins **must not** weaken security policies (`08-guides/flutter/security/`, `security-auditor` skill).
- Plugins **must not** inject secrets into prompts or logs.

---

## Steps to add a plugin

1. **Define hook points** you need from `../hooks/README.md` (`pre-route` … `pre-release-gate`).
2. **Author `plugin.json`** validated against `plugin-schema.json` (use JSON Schema tooling or `ajv` in CI).
3. **Document side effects:** filesystem, network, MCP — in plugin README.
4. **Register** with your host runtime (outside this repo’s core manifest unless you extend `prompt-runtime-ts` deliberately).
5. **Test:** run route resolution and one full `build` with plugin enabled; confirm `post-execute` still applies redaction rules.

---

## Example `plugin.json` (illustrative)

```json
{
  "id": "example-telemetry",
  "version": "1.0.0",
  "description": "Emits structured run metrics to .promptos/metrics on post-execute.",
  "hookPoints": ["post-execute"]
}
```

---

## Validation

- JSON must satisfy `plugin-schema.json` (`required`: `id`, `version`, `description`, `hookPoints`).
- `hookPoints` entries must be from the enum only (no ad-hoc hook names).

---

## References

- Hooks: `../hooks/README.md`
- Skill authoring: `../SKILL-AUTHORING.md`
- Precedence (how overrides stack): `../../00-core/skill-precedence-policy.md`

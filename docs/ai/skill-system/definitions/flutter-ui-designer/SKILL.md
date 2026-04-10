# flutter-ui-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Screen structure, design system, aesthetics, domain-specific visual rules, and mobile interaction states.

## Other Common Requests This Skill Should Cover

- Generating premium visual aesthetics (gradients, glassmorphism, micro-animations)
- Enforcing domain-specific rules from Playbooks (e.g., Fintech tabular alignment, Ecommerce sticky CTAs).
- Bridging BA Requirements into UI Specs via `ba-to-design`.
- Emitting JSON payloads for `Stitch AI` via the MCP Protocol.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Technical Constraints

- **Premium Mandate:** You must prioritize aesthetic excellence. Never use default, flat material drop shadows. Substitute with soft, diffused shadows and HSL-curated color palettes.
- **Domain Matching:** If designing for Fintech, Healthcare, or E-commerce, you MUST load the respective domain playbook and apply its specific structural and psychological constraints.
- **Micro-animations:** Always specify micro-interactions (e.g., tap scale-down, staggered list loads). Statically snapped interfaces are not acceptable.
- **Token Map Extraction:** If a Design JSON output is requested for Stitch AI or an external MCP, format it strictly according to the Stitch AI design bridge protocol.

## Example

**Example request:** Design a Fintech balance screen from Figma file.

**Example Flutter composition snippet:**
```dart
Scaffold(
  body: Container(
    // Glassmorphic background
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
      ),
    ),
    child: SafeArea(
      child: Center(
        child: Text(
          isObscured ? '••••••••' : '\$12,450.00',
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()], // Domain rule applied
          ),
        ),
      ),
    ),
  ),
)
```

## Anti-patterns

- Minimal Viable Product (MVP) mentality: Using flat Primary Blue colors with boxy unrounded corners.
- Fixed pixel sizes that break large text and system font scaling.
- Decorative-only `Image.network` without `cacheWidth` and error/loading placeholders on slow networks.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Aesthetics guide: `docs/ai/guides/flutter/ui/aesthetics-and-visual-excellence.md`
- Stitch AI design bridge: `docs/ai/guides/mcp/stitch-ai/design-bridge-from-figma.md`
- Fintech playbook: `docs/ai/guides/flutter/ui/domain-playbooks/fintech.md`
- E-commerce playbook: `docs/ai/guides/flutter/ui/domain-playbooks/ecommerce.md`
- Healthcare playbook: `docs/ai/guides/flutter/ui/domain-playbooks/healthcare.md`

# Stitch AI Design Bridge From Figma

This bridge is complementary to route-level structured outputs: keep the route contract first, then append any machine-readable bridge payload.

## Context

Converting design mockups (Figma) into production-ready Flutter code often suffers from visual drift. AI agents need a formalized "Stitch Protocol" to extract design metadata accurately without hallucinations, or to output design tokens in a machine-readable format that a secondary "Stitch AI" or code-generation engine can consume.

## Core Constraints

- **The Handshake Protocol:** When an external tool or the user asks for a "Design Synthesis" or a "Stitch Payload" from a BA requirement or a mockup image, the AI MUST output a JSON-wrapped `Design Tokens Spec` immediately following the markdown explanation. This JSON serves as the bridge.
- **Figma Node Resolution:** If you are provided with a Figma Node ID or access to a Figma API response, you MUST NEVER guess the CSS/Dart translations. Extract exact values: `fills[0].color`, `boxShadow`, `cornerRadius`, and `primaryAxisAlignItems` (Auto Layout). If Auto Layout is missing from the Figma node, you MUST explicitly warn the user that the Figma design is not responsive.
- **Token Hierarchy:** Never output raw Color Hex codes directly in the Flutter Widget tree in a Stitch payload. Always map Figma styles to a cohesive `ThemeData` token map (e.g., `#FF0000` -> `colorScheme.error`).

## Standard Stitch AI JSON Schema

When asked to output a Stitch Payload, bundle the visual rules into this exact structure inside a ```json block:

```json
{
  "stitch_protocol_v1": {
    "component_name": "CheckoutScreen_Submit",
    "domain_context": "ecommerce",
    "screen_anatomy_zones": {
      "zone4_sticky_action": {
        "component_type": "Button_Primary",
        "padding_grid": [16, 24, 16, 24], 
        "margin_grid": [0, 0, 32, 0]
      }
    },
    "tokens": {
      "background_token": "color/semantic/primary/base",
      "on_color_token": "color/semantic/primary/on-color",
      "corner": "radius/interactive/medium"
    },
    "interaction_physics": {
      "default_elevation": 0,
      "hover_lightness_shift": "+10%",
      "press_physics": "scale_0.95_darken_step_600",
      "disabled_opacity": "38%"
    },
    "typography": {
      "role": "typography/label/large"
    },
    "flutter_mapping": "ElevatedButton inside a SafeArea anchored in Zone 4 (BottomNavigationBar)."
  }
}
```

## Execution Steps for the Agent

1. **Verify Stitch Request:** Identify if the user wants dart code (`flutter-coder`) or a design-to-code token map (`Stitch Payload`).
2. **Translate Auto Layout:** Convert Figma's `hug`/`fill` into Flutter's `MainAxisSize.min` and `Expanded`.
3. **Generate the Payload:** Output the visual architecture in markdown for the human, and the JSON Stitch Protocol block for the machine.
4. **Warn on Unimplementable Designs:** If the requested design heavily relies on complex Figma boolean operations or unsupported SVG masks, warn the user that it requires manual `CustomPaint` or `.riv` (Rive) export.

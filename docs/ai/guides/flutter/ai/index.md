# Flutter AI Section Index

Use this section for Flutter AI product patterns, editor workflows, rules files, local AI features, and agentic app surfaces.

Examples:

- `flutter/ai/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `rules-and-editor-workflows` | local rules files, compact variants, editor or agent workflow boundaries | `flutter/ai/rules-and-editor-workflows.md` |
| `architecture-and-genkit` | repository layering for AI features, Genkit-style flows, model orchestration | `flutter/ai/architecture-and-genkit.md` |
| `agentic-tooling` | exposing app capabilities as tools, tool dispatchers, and human-in-the-loop safeguards | `flutter/ai/agentic-tooling.md` |
| `generative-ui-and-streaming-ux` | streaming UX, generative UI shells, and user feedback loops | `flutter/ai/generative-ui-and-streaming-ux.md` |
| `local-ai-mlkit-and-tflite` | on-device inference, ML Kit, TFLite, and local vector search | `flutter/ai/local-ai-mlkit-and-tflite.md` |
| `examples` | Flutter AI workflow examples and mixed-scenario recognition | `flutter/ai/examples.md` |

## Retrieval Rules

- start with `rules-and-editor-workflows` when the question is about rules files, compact variants, or editor workflow setup
- add `architecture-and-genkit` when the question is about how AI code should sit inside the Flutter architecture
- add `agentic-tooling` when the app exposes explicit tools or app actions to a model
- add `generative-ui-and-streaming-ux` when the question is about streaming, partial rendering, or generative UI surfaces
- add `local-ai-mlkit-and-tflite` when the question is about on-device inference, privacy, or offline AI capability
- load `flutter/ai/examples.md` when the request mixes many Flutter AI concerns
- load `docs/ai/guides/mcp/index.md` alongside this section when the question depends on MCP servers, connectors, or tool-assisted research

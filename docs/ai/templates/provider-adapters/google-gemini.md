# Google Gemini Adapter

Use when the serving stack targets Gemini models or Gemini-compatible editors.

- keep critical instructions first, large context blocks after that, and the concrete task near the end
- use explicit markdown or tag boundaries between system rules, route context, and user request
- use schema-backed structured outputs when the serving layer supports them
- avoid redundant repeated instructions; rely on route contract plus schema instead of prose duplication
- preserve mobile-first constraints, source dates, and tool-boundary rules exactly as written

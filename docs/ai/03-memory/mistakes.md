# Mistakes

Recurring mistakes to prevent during prompt-system authoring and maintenance.

## Known Mistakes

### Giant Prompt Sprawl

- issue: adding more prompt text to every request instead of fixing routing, context selection, or contracts
- why it happened: prompt failures were treated as missing instructions rather than architecture problems
- correct approach: move stable rules into `00-core/`, isolate task prompts, and tighten retrieval instead of globally expanding every prompt
- detection rule: if the same instruction appears across many task prompts or the package keeps growing for unrelated tasks, stop and refactor the layer split

### Mixed Route Outputs

- issue: answering one request with multiple route styles or multiple output contracts
- why it happened: ambiguous user intents were handled by merging unrelated response formats
- correct approach: choose one primary route, record secondary intents, and defer follow-up work instead of mixing contracts
- detection rule: if an answer needs sections from more than one contract, routing was likely not resolved cleanly

### Placeholder Context Left In Runtime

- issue: repository-level context or memory files were left as empty templates
- why it happened: scaffolding was created before stable repo facts were written down
- correct approach: fill repository-level context and memory with real prompt-platform facts, then override per downstream product when needed
- detection rule: search for placeholder-only bullets, `Fill this file`, or memory files without active entries

### Route Change Without Eval Coverage

- issue: route patterns or contract mappings changed without updating regression coverage
- why it happened: doc and manifest edits were treated as low-risk text changes
- correct approach: update eval cases and run validation whenever routing behavior or contract mapping changes
- detection rule: any manifest diff without matching eval or validation review is a release risk

### Rule Duplication Across Layers

- issue: the same policy was copied into core rules, task prompts, and operator docs
- why it happened: quick fixes were added in the nearest file instead of the correct layer
- correct approach: keep global rules in `00-core/`, route behavior in `02-tasks/`, and memory in `03-memory/`
- detection rule: if a policy must be edited in several files to stay consistent, it probably lives in the wrong layer

## Update Rules

- add entries only after the mistake has repeated or caused meaningful maintenance cost
- keep detection rules concrete enough to support audits
- remove entries when the underlying workflow no longer exists

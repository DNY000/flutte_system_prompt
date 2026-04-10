# AI Systems Examples

When the runtime supports structured outputs, keep the selected route contract paired with its matching schema throughout these examples.

Use these examples to recognize prompt-system and agent-system decisions.

## Example 1: Prompt Keeps Growing

Context:

- one giant prompt mixes architecture, code, design, testing, and CI/CD rules
- answers are long and inconsistent
- users keep repeating project context manually

Default decision:

- split into system prompt, task prompt, project context, output contract, structured-output schema, and memory

Why:

- the real issue is prompt architecture, not missing instructions

Switch:

- if only one narrow workflow exists and context is tiny, a simpler prompt can still be enough

## Example 2: Should We Add More Agents

Context:

- one agent handles architecture, research, code, and CI
- outputs are slow and mixed
- research questions and implementation tasks are independent

Default decision:

- keep one main agent and add one research specialist only for current-fact checks

Why:

- the split is justified by role and source differences, but full fragmentation would add overhead

Switch:

- if implementation can continue while research runs in parallel, spawn a second specialist worker too

## Example 3: Prompt Optimization Without Evals

Context:

- team keeps changing prompts after reading bad outputs
- no dataset of representative requests exists
- no one knows whether the new prompt is actually better

Default decision:

- build a small benchmark dataset and regression checks before further prompt rewrites

Why:

- without evals, prompt optimization becomes subjective and unstable

Switch:

- if the workflow is still exploratory, keep changes light but start collecting benchmark examples immediately

## Example 4: MCP Or Manual Context

Context:

- package versions, release notes, and issue tracker data are copied into prompts manually
- facts go stale quickly

Default decision:

- move time-sensitive structured data retrieval into MCP or research workflows

Why:

- manual context copying does not scale and increases stale-answer risk

Switch:

- if the data is stable and project-local, a short curated context file can still be cheaper

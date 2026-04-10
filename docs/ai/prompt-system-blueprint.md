# Central Prompt System For Dart/Flutter

## 1. Goal

Build one unified prompt system for `Dart` and `Flutter` so the AI works against a stable operating model instead of ad hoc requests.

This system should cover:

- Architecture
- Security
- Performance
- Code quality
- UI/UX design
- BA and requirement analysis
- Auto test
- CI/CD
- Token reduction
- Input/output cleanup
- Persistent context
- AI auto research
- MCP connect
- Multi-agent workflows
- Knowledge accumulation
- Clean Markdown structure

## 2. Core Principle

Do not build one giant prompt for everything.

Build a `layered prompt system`:

1. `Core System Prompt`
2. `Task Prompt`
3. `Context Prompt`
4. `Quality Gates`
5. `Memory/Knowledge`
6. `Execution Connectors`

## 3. Proposed Architecture

### 3.1 Core System Prompt

This is the global rule set for every task.

It should define:

- AI focuses on `Dart` and `Flutter`
- Prefer clean architecture, maintainability, and testability
- Prefer safe code with low side effects
- Always surface assumptions, risks, and trade-offs
- Always return clean Markdown
- Ask for only missing critical context, do not over-infer

### 3.2 Task Prompt

Each discipline gets its own prompt:

- `architecture.md`
- `security.md`
- `performance.md`
- `code-review.md`
- `design.md`
- `ba.md`
- `testing.md`
- `ci-cd.md`
- `research.md`

Task prompts should contain only:

- task goal
- minimum required input
- quality checklist
- output format

### 3.3 Context Prompt

This layer keeps persistent project context.

It should hold:

- product summary
- business rules
- coding conventions
- package constraints
- current architecture
- module definitions
- technical decisions
- anti-patterns to avoid

Keep it short and stable.

### 3.4 Quality Gates

Every answer or code change should be checked against:

- requirement fit
- architecture impact
- security risk
- performance regression risk
- test coverage impact
- CI/CD impact
- output cleanliness

### 3.5 Memory/Knowledge

This is where project knowledge accumulates.

Recommended files:

- `decisions.md`
- `patterns.md`
- `mistakes.md`
- `glossary.md`
- `modules.md`

### 3.6 Execution Connectors

This layer links AI to real project data:

- `MCP` for docs, filesystem, schemas, design source, issue tracker
- `research pipeline` for package docs, changelogs, and best practices
- `multi-agent orchestration` for parallel specialist roles

## 4. Recommended Folder Structure

```text
docs/
  ai/
    core/
      system-prompt.md
      output-rules.md
      token-rules.md
    context/
      project-context.md
      architecture-context.md
      business-context.md
    tasks/
      architecture.md
      security.md
      performance.md
      code.md
      design.md
      ba.md
      testing.md
      ci-cd.md
      research.md
    memory/
      decisions.md
      patterns.md
      mistakes.md
      glossary.md
      modules.md
    templates/
      request-template.md
      review-template.md
      implementation-template.md
      research-template.md
```

## 5. Problem To Solution Mapping

### 5.1 Architecture

Create `architecture.md` with checks for:

- feature and module boundaries
- state management rules
- dependency direction
- data/domain/presentation separation
- package layout
- migration strategy

### 5.2 Security

Create `security.md` with checks for:

- secret management
- token and session storage
- input validation
- sensitive logging
- SSL pinning when required
- secure local storage
- permission handling
- dependency risk review

### 5.3 Performance

Create `performance.md` with checks for:

- rebuild control
- isolate or background work
- network caching
- image optimization
- startup time
- memory churn
- list rendering
- profiling expectations

### 5.4 Code

Create `code.md` with standards for:

- naming
- error handling
- null safety
- layer responsibility
- extension usage
- imports
- lint alignment

### 5.5 Design

Create `design.md` with rules for:

- design tokens
- component consistency
- accessibility
- responsive behavior
- animation restraint
- empty/loading/error states

### 5.6 BA

Create `ba.md` so AI can translate requests into technical form:

- business objective
- user flow
- acceptance criteria
- edge cases
- analytics or tracking needs
- non-functional requirements

### 5.7 Auto Test

Create `testing.md` with rules for:

- unit tests for domain and services
- widget tests for UI logic
- golden tests when UI is stable
- integration tests for critical flows
- mock and fake strategy

### 5.8 CI/CD

Create `ci-cd.md` with a minimum pipeline:

- format
- analyze
- test
- build
- artifact
- release notes
- versioning
- environment separation

### 5.9 Token Reduction

Do not load all context into every prompt.

Apply these rules:

- split prompts by layer
- load only the files needed for the task
- use short checklists instead of long prose
- standardize output schema
- store long-term decisions in memory, do not repeat them

### 5.10 Input And Output Cleanup

Create one `input normalization template`:

- goal
- related files or modules
- constraints
- expected output
- priority

Create one `output rule`:

- short summary
- assumptions
- recommendation
- code or patch
- test impact
- risk

### 5.11 Persistent Context

Do not keep critical context only in the user's head.

Write it down:

- project context
- active decisions
- current milestone
- known blockers

### 5.12 AI Auto Research

Create `research.md` so AI:

- uses primary or official sources when needed
- compares package or framework versions
- states exact dates and versions
- separates fact from inference
- summarizes before recommending

### 5.13 MCP Connect

Connect AI to:

- source code
- design source
- internal docs
- issue tracker
- release log
- package references

MCP reduces manual prompting and improves context accuracy.

### 5.14 Multi-Agent

Do not use many agents by default.

Split work only when roles are independent:

- Agent 1: architecture
- Agent 2: Flutter UI
- Agent 3: test and QA
- Agent 4: research and dependency validation

The main agent should aggregate and apply final quality gates.

### 5.15 Knowledge Accumulation

After each task, update:

- new decisions
- new recurring mistakes
- reusable patterns
- new checklist items if needed

Without memory updates, AI will repeat the same mistakes.

### 5.16 Clean Markdown

Use this rule set:

- one file, one purpose
- flat headings
- short checklists
- avoid long narrative prompts
- prefer templates and explicit fields

## 6. Practical Rollout Plan

### Phase 1: Standardize The Base

Decide first:

1. coding standards for Dart/Flutter
2. target architecture model
3. expected output format
4. most common AI task types

### Phase 2: Write The Core

Create these first:

1. `system-prompt.md`
2. `project-context.md`
3. `output-rules.md`
4. `request-template.md`

### Phase 3: Write Specialist Prompts

Recommended order:

1. `code.md`
2. `architecture.md`
3. `testing.md`
4. `security.md`
5. `performance.md`
6. `ci-cd.md`
7. `design.md`
8. `ba.md`
9. `research.md`

### Phase 4: Add Memory

Create:

1. `decisions.md`
2. `patterns.md`
3. `mistakes.md`

### Phase 5: Add Automation

Only after the prompt system is stable:

1. MCP connectors
2. research workflow
3. multi-agent orchestration
4. CI integration for AI-generated artifacts

## 7. What You Should Do First

If you start from zero, the right order is:

1. define what AI will do most often in the Flutter project
2. write a short and strict `core system prompt`
3. write a short but durable `project context`
4. split prompts by discipline instead of one huge prompt
5. define one fixed `output schema`
6. create `memory files` for accumulated knowledge
7. only then add `MCP`, `research`, and `multi-agent`

## 8. Bottom Line

What you need is not `one prompt`.

What you need is `a prompt operating system`.

The correct focus is:

- layered prompts
- short but durable context
- accumulated memory
- quality gates
- real-data connectors

If you build it this way, the AI will be more stable, use fewer tokens, require less repetition, and fit a real Flutter project much better.

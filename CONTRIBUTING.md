# Contributing to Flutter Prompt OS (FPOS)

FPOS is a community-driven Agentic Operating System. We welcome contributions that harden our standards, improve our routing, or expand our specialist knowledge packs.

## 🛠️ How to Contribute

### 1. Improving the Knowledge Base (`docs/ai/`)
The `docs/` folder is the "Brain" of FPOS. 
- **Identify Gaps**: If you notice a missing standard (e.g., a new Flutter 4.0 feature or a new Supabase package), create a new guide.
- **Standards**: Follow the existing format in `docs/ai/guides/`. Guides should be evidence-first and focus on "Lethal Edge" best practices.

### 2. Adding a New Skill (`agents/SKILLS.md`)
Skills are modular capabilities. To add one:
1.  **Define the Skill**: Create a new `SKILL.md` under `docs/ai/skill-system/definitions/<skill-id>/`.
2.  **Declare Contracts**: Specify what input/output contracts the skill satisfies.
3.  **Register**: Add the skill to the registry in `agents/SKILLS.md`.

### 3. Modifying Agent Roles (`agents/`)
Agents are role profiles that orchestrate skills. 
- If you find that an agent (e.g., `execute`) is missing context or needs a personality adjustment to better handle tests, modify the corresponding file in `agents/`.

### 4. Improving CLI/Runtime (`tools/`)
The engines in `tools/` are the backbone of FPOS automation.
- **NodeJS/TypeScript**: Contributions to the `prompt-runtime-typescript` are highly encouraged for better automated routing.
- **PowerShell**: Maintenance of the `prompt-cli.ps1` CLI for Windows/macOS users.

## 🧪 Testing Your Changes

Before submitting a Pull Request, please ensure compatibility:
1.  **Validate Manifest**: Run `npm run validate-manifest` in `tools/prompt-runtime-typescript/`.
2.  **Run Evals**: Execute `./tools/prompt-powershell/run-evals.ps1` (or use the TS runtime equivalent) to ensure no regressions in AI output quality.

## 📜 Repository Standards

- **Language**: All prompts, documentation, and tools must be in **English**.
- **No Hallucinations**: Ensure all code snippets in guides are verified against the latest Stable version of Flutter/Dart.
- **Atomic Commits**: Use descriptive commit messages following the Conventional Commits specification.

Thank you for helping us keep the "Digital Iron Discipline" alive!

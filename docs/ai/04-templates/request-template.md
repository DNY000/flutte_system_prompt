# Request Template

Use this block before calling `build`, or as the request section inside a manual prompt package.

## Mandatory Prompt Format

```text
Role: Bạn là senior Flutter developer
Task: Giải quyết vấn đề X
Context:
- requirement: <clear requirement>
- code/input: <real code snippet or related file path>
- expected result: <clear expected result>
Constraints:
- Ngắn gọn
- Không lan man
- Đúng trọng tâm
Output:
- Root cause
- Fix code
- Notes (optional)
```

## Input Clarity Rules (Required)

- Always provide all 3:
  - clear requirement
  - real code snippet or related code file
  - expected result
- If one is missing, ask one short clarification question and wait.

## Context Control

- include only relevant code or files
- do not dump the whole project unless explicitly requested
- keep context to minimum sufficient scope

## Few-shot Usage

- add examples only for repetitive tasks (for example API or widget generation)
- keep examples minimal and aligned to the same output format

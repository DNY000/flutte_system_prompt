# Evals And Regression Pack

## Use For

- prompt evals
- benchmark datasets
- route regression tests
- contract compliance checks
- trace grading for agent workflows

## Default Decisions

- create a representative benchmark set before major prompt rewrites
- test both route resolution and final output shape
- treat prompt updates like code changes that require regression checks
- grade agent traces when the failure may come from orchestration rather than final wording
- use narrow graders for one property at a time

## Decision Switches

- if routing changes often, add route snapshot tests first
- if answers vary widely for similar tasks, add contract compliance and style checks
- if multi-agent runs fail in complex ways, add trace grading before rewriting prompts
- if a prompt optimizer is used, always review and compare against a baseline before publishing

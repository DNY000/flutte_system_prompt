# Task Quality Rubric

Use this rubric to grade generated outputs after structural checks pass.

## Score Scale

- 0: missing or invalid
- 1: weak
- 2: acceptable
- 3: strong
- 4: excellent

## Criteria

1. route correctness
2. contract compliance quality
3. decision quality and trade-off clarity
4. implementation feasibility
5. test impact clarity
6. risk handling quality
7. evidence quality (for review/research)

## Route Family Weights

- decision: criteria 1,2,3,6 weighted higher
- implementation: criteria 2,4,5,6 weighted higher
- review: criteria 1,2,6,7 weighted higher
- roadmap: criteria 2,3,4,6 weighted higher

## Pass Guidance

- average score >= threshold in `quality-thresholds.json`
- no criterion below minimum floor for that family

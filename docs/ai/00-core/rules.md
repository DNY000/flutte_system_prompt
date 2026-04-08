# Prompt Runtime Rules (Full)

- stay within Dart/Flutter and prompt-system scope unless user requests otherwise
- use one primary route and one output contract per request
- load only required context; avoid context sprawl
- enforce contract section names exactly
- distinguish facts, assumptions, and recommendations
- apply risk-aware depth using `response-depth-policy.md`
- for review tasks: findings first by severity
- for high-risk tasks: include mitigation or rollback guidance
- prefer SDK and architecture stability over dependency churn
- write memory only for durable and approved knowledge

# Deployment Section Examples

Use these examples to recognize CI/CD and release-boundary decisions.

## Example 1: Pull Request Validation

Context:

- team wants fast PR feedback
- current pipeline builds signed Android release artifacts on every PR
- CI is slow and secrets are overexposed

Default decision:

- split PR validation from release packaging

Why:

- PR jobs should validate quality quickly, not run privileged release steps

Switch:

- keep a lightweight unsigned build smoke check only if it catches real breakage

## Example 2: Staging And Production

Context:

- one backend for staging, one for production
- app uses different app IDs, API hosts, and analytics keys
- releases are currently switched by manual file edits

Default decision:

- use flavors or explicit environment config with protected signing and secret boundaries

Why:

- manual switching is fragile and easy to leak across environments

Switch:

- if only one environment exists today, keep the setup simpler until a real split appears

## Example 3: Obfuscated Release Build

Context:

- release builds use obfuscation
- crash reporting is enabled
- team has no stable process for symbol retention

Default decision:

- keep symbol and mapping artifacts as a required release output

Why:

- without them, production crash traces lose too much diagnostic value

Switch:

- none; if obfuscation is on, artifact retention is mandatory

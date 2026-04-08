# Auth Secrets And Storage Pack

## Use For

- token and credential storage
- auth and re-auth decisions
- secrets handling
- biometric or device-auth integration

## Default Decisions

- never ship real secrets inside the client
- store sensitive tokens only when required and use platform-backed secure storage
- keep auth refresh and logout behavior explicit
- use platform authentication APIs instead of custom security flows

## Decision Switches

- if the data is recoverable from the backend, avoid local persistence
- if compromise impact is high, require stronger session and re-auth controls
- if plain preferences are suggested for secrets, the default answer is no

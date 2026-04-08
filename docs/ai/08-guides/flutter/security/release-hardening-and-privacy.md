# Release Hardening And Privacy Pack

## Use For

- release configuration hardening
- logging and analytics redaction
- permission minimization
- privacy-sensitive data handling

## Default Decisions

- strip verbose debug logging from release builds
- keep permissions limited to concrete feature needs
- redact sensitive identifiers from logs, analytics, crash reports, and notifications
- treat obfuscation as defense-in-depth only, not as secret protection

## Decision Switches

- if a feature only needs coarse data, do not request broader permissions
- if release builds expose debug toggles or endpoints, fix that before shipping
- if analytics events can identify users or sessions, review privacy impact before logging

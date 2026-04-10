# Platform Integration Domain

## Use For

- package vs platform channel vs FFI
- `MethodChannel` vs `EventChannel`
- native ownership boundaries

## Default Decisions

- package
  Use when a mature solution already fits.
- platform channel
  Use for app-specific host platform API access.
- FFI
  Use for native library interoperability rather than host API calls.
- `MethodChannel`
  Request-response.
- `EventChannel`
  Event streams.

## Decision Switches

- if the integration becomes foundational, wrap it behind an adapter
- widgets should not know channel names or native codecs
- if security or release risk is high, combine with security and CI rules

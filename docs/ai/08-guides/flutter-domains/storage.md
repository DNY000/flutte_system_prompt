# Storage Domain

## Use For

- memory vs disk
- preferences vs secure storage
- file storage vs database
- cache vs source of truth

## Default Decisions

- in-memory state
  Use for transient runtime state that can be recomputed.
- preferences-style storage
  Use for simple non-sensitive user settings and flags.
- secure storage
  Use for sensitive tokens or secrets that must live on device.
- file storage
  Use for larger document-like payloads and user-managed files.
- database
  Use for structured, queryable, relational, or long-lived offline data.
- cache
  Use when the data is disposable and can be refreshed from a source of truth.

## Decision Switches

- if the data is sensitive, do not use ordinary preferences
- if the data needs querying and relationships, prefer a database over ad hoc files
- if the data is derived and disposable, prefer cache not durable primary storage
- if package choice matters, escalate to `package-governance` or research

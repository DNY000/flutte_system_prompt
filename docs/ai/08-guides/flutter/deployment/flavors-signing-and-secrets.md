# Flavors Signing And Secrets Pack

## Use For

- environment separation
- Android and iOS flavor strategy
- signing workflows
- protected secret handling

## Default Decisions

- separate staging and production through flavors, schemes, or explicit environment config
- keep signing only in protected release jobs
- keep bundle IDs and application IDs stable and intentional
- derive app versioning from project metadata, not scattered manual edits

## Decision Switches

- if staging and production share secrets, the boundary is too weak
- if pull-request jobs can sign builds, the pipeline is overprivileged
- if a flavor changes runtime behavior, test each release path explicitly

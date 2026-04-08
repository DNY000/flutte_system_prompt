# Layering And Dependencies Pack

## Use For

- presentation, domain, data layering
- dependency direction
- repository, service, and mapper boundaries
- optional use-case layers

## Default Decisions

- keep presentation dependent on stable state or service boundaries, not raw data sources
- use repositories to hide remote or local data details
- add mappers only when models differ across layers
- add use cases only when business rules are reused, complex, or need independent testing

## Decision Switches

- if the app is small, avoid ceremonial layers
- if business rules span many screens or data sources, a use-case layer is justified
- if UI imports transport or database types directly, layering is too weak

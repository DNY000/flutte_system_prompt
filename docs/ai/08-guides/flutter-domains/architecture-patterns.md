# Architecture Patterns Domain

## Use For

- repository
- use case
- adapter
- mapper
- facade
- strategy

## Default Decisions

- `Repository`
  Abstract data-source access.
- `Use case`
  Name and isolate non-trivial business actions or orchestration.
- `Adapter`
  Bridge plugin or external API shape to internal code.
- `Mapper`
  Translate across boundary models.
- `Facade`
  Simplify multiple subsystems behind one stable surface.
- `Strategy`
  Swap behavior by policy.

## Decision Switches

- if a pattern adds ceremony without reducing coupling, reject it
- if business logic is trivial and local, do not force a use-case
- if external API shapes leak inward, use an adapter or mapper

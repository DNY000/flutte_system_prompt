# Modules

Persistent map of product modules and ownership boundaries.

## Template

- module_name:
- business_goal:
- owned_features:
- inbound_dependencies:
- outbound_dependencies:
- data_sources:
- critical_flows:
- test_focus:
- release_risk:

## Boundary Rules

- each module owns its state transitions and error mapping
- cross-module access must happen through explicit interfaces
- do not bypass boundaries from UI directly to external services
- shared utilities must not become hidden business-logic containers

## Promotion Rules

- add a module only after boundaries are reviewed
- update dependencies when architecture decisions change
- mark deprecated modules with migration target and sunset date

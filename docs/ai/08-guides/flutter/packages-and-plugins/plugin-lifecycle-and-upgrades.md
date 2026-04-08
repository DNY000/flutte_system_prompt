# Plugin Lifecycle And Upgrades Pack

## Use For

- plugin adoption review
- upgrade and maintenance policy
- federated plugin risk
- wrapper ownership around third-party plugins

## Default Decisions

- prefer mature plugins with recent maintenance and clear platform support
- wrap foundational plugins behind app-owned adapters
- test plugin upgrades on the highest-risk flows before broad rollout
- avoid depending directly on plugin APIs across the whole app

## Decision Switches

- if the plugin is critical to auth, payments, storage, or navigation, wrap it early
- if the maintainer signal is weak, reduce blast radius with a narrow adapter boundary
- if a plugin upgrade changes native behavior, require integration validation before merge

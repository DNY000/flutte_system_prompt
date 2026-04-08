# Packages And Plugins Section Index

Use this section for dependency governance, plugin adoption, upgrade safety, and wrapper strategy.

Examples:

- `flutter/packages-and-plugins/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `package-governance` | SDK-first, package selection, wrapper strategy, custom vs package | `flutter/domains/package-governance.md` |
| `plugin-lifecycle-and-upgrades` | plugin ownership, maintenance checks, upgrade workflow, federated plugin risk | `flutter/packages-and-plugins/plugin-lifecycle-and-upgrades.md` |
| `practical-package-selection` | common package defaults for images, networking, storage, modeling, authentication, and platform bridges | `flutter/packages-and-plugins/practical-package-selection.md` |

## Retrieval Rules

- start with `package-governance`
- add `plugin-lifecycle-and-upgrades` when native surface area, upgrade risk, or maintenance quality matters
- add `practical-package-selection` when the user asks which package or library to choose for a concrete Flutter task
- load `flutter/packages-and-plugins/examples.md` when the user asks which package to use without stable constraints yet

# Plugins

This folder defines extension points for runtime plugins.

## Required Plugin Files

- `plugin.json`: plugin metadata and capabilities
- optional docs for behavior and safety

## Safety Rules

- plugins must not bypass output-contract enforcement
- plugins must not weaken security policies

## Physical packages

If you ship a plugin as its own directory, keep a manifest validated against `plugin-schema.json` in that tree (path is up to your workspace). Policy and schema remain in this folder.

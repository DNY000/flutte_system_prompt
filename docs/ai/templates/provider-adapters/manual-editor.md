# Manual Editor Adapter

Use for editors or chat tools that expose only one or two prompt fields and do not support schema-native output APIs.

- keep the package compact: system prompt, output rules, token rules, one task prompt, one contract, and only the guide packs that materially change the answer
- paste only the selected contract schema entry, not the entire schema catalog, when the editor supports JSON mode
- if the editor does not support schema-native outputs, keep the markdown shell as the enforcement target
- for ambiguous routes, make the key assumption explicit in the first section instead of opening a second contract

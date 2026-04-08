# Network Links And WebView Pack

## Use For

- network trust decisions
- certificate validation and pinning
- deep link and app-link validation
- WebView security review

## Default Decisions

- require TLS and valid endpoint verification
- use certificate or identity pinning only when the endpoint is controlled and the threat model justifies it
- validate deep-link inputs before routing or acting on them
- keep sensitive auth outside general-purpose WebViews when possible

## Decision Switches

- if the flow crosses apps or browsers, validate ownership and replay risk explicitly
- if WebView content can execute arbitrary input, treat it as a high-risk boundary
- if custom TLS logic bypasses validation, fix that before adding defense-in-depth features

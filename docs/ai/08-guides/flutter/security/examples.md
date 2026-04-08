# Security Section Examples

Use these examples to recognize common mobile security decisions.

## Example 1: Refresh Token Handling

Context:

- app uses OAuth
- access token expires quickly
- refresh token must survive restarts
- device compromise would be serious

Default decision:

- store refresh token only in platform-backed secure storage
- keep access token in memory when possible

Why:

- sensitive tokens need stronger at-rest protection and smaller exposure windows

Switch:

- if backend supports stronger device binding or shorter sessions, reduce local token lifetime further

## Example 2: Certificate Pinning Proposal

Context:

- public consumer app
- backend is fully under company control
- team suggests blanket certificate pinning for all environments

Default decision:

- do not enable pinning by default unless the threat model and operational process are mature

Why:

- pinning raises operational failure risk and only makes sense when endpoint ownership and rotation discipline are strong

Switch:

- if the app faces higher interception risk and the backend rotation process is mature, pinning can be justified

## Example 3: WebView Login

Context:

- team wants to embed full sign-in flow inside a general WebView
- page includes third-party content and dynamic redirects

Default decision:

- avoid general-purpose WebView for sensitive auth if a safer platform or browser-based flow exists

Why:

- this creates a larger trust boundary and makes validation harder

Switch:

- if a WebView is unavoidable, lock down navigation, origin, and injected capabilities aggressively

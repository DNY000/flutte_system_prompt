# Routing algorithm (manifest matchers)

This document is the **normative description** of how a user query becomes a `route_id`, aligned with `tools/prompt-cli/aiprompt.ps1` and `tools/prompt-runtime-ts/src/router.ts`.

## Inputs

- **Query:** natural language string from the user (may include noise; not validated for grammar).
- **Manifest:** `tools/prompt-cli/routes.json` — each route lists `queryPatterns[]` (short phrases or keywords).

## Normalization

1. Unicode NFD decomposition; strip combining marks (accent folding).
2. Lowercase ASCII.
3. Replace any run of non `[a-z0-9]` with a single space; trim.

Empty normalized query cannot match.

## Scoring one pattern

Let `q` = normalized query, `p` = normalized pattern.

1. **Substring tier (strong signal):** if `q` contains `p` as a substring → score = **1000 + length(p)** (longer `p` wins over shorter at this tier).
2. Otherwise **token overlap:** split `p` and `q` on spaces into tokens.
   - Let `M` = number of pattern tokens that appear in `q`.
   - If `M == 0` → score **0**.
   - Else score = **M × 10 − (patternTokenCount − M)** (favors covering the pattern with fewer missing tokens).

## Selecting the winning route

1. For each **(route, pattern)** pair in manifest order (`routes[]` order, then each route’s `queryPatterns` order), compute the score.
2. Keep the pair with the **strictly greater** score (`>`). If scores tie, **keep the first** pair seen (manifest order). This matches PowerShell iteration semantics in `Resolve-RouteFromQuery`.
3. If no pair scores **> 0**, resolution **fails**.

## Diagnostics (TypeScript)

- `topRouteCandidates(query, manifest, k)` — best score **per route** (best pattern only), sorted by score descending, then **route declaration order** for ties.
- CLI flag `--explain` on `prompt-runtime-ts` adds `explain.topCandidates` and **command vs route** hints (see `skill-precedence-policy.md` / agent docs).

## Limits

- No semantic embeddings; ambiguous queries can map to the “wrong” specialist if patterns overlap.
- Mitigation: expand `route-regression.json`, tune patterns, use `--explain` in triage.

## Related

- Human-facing priority rules: `routing-rules.md`
- Route → contract table: `output-contracts.md` (“Contract Routing Rules”)
- Manifest validation: `npm run validate-manifest` in `tools/prompt-runtime-ts`

import { normalizeText } from "./normalize.js";
export function scorePattern(query, pattern) {
    const q = normalizeText(query);
    const p = normalizeText(pattern);
    if (!q || !p)
        return 0;
    if (q.includes(p))
        return 1000 + p.length;
    const qTokens = new Set(q.split(/\s+/).filter(Boolean));
    const pTokens = p.split(/\s+/).filter(Boolean);
    let matches = 0;
    for (const t of pTokens) {
        if (qTokens.has(t))
            matches += 1;
    }
    if (!matches)
        return 0;
    return matches * 10 - (pTokens.length - matches);
}
/**
 * Best (pattern, score) for each route — same as scanning that route's queryPatterns with strict `>` updates.
 */
export function bestScoresPerRoute(query, manifest) {
    const candidates = [];
    for (const route of manifest.routes) {
        let bestScore = -1;
        let bestPattern = "";
        for (const pattern of route.queryPatterns) {
            const score = scorePattern(query, pattern);
            if (score > bestScore) {
                bestScore = score;
                bestPattern = pattern;
            }
        }
        if (bestScore > 0) {
            candidates.push({ routeId: route.routeId, score: bestScore, matchedPattern: bestPattern });
        }
    }
    return candidates;
}
/**
 * Ordered by score desc, then manifest route order (parity with prompt-cli.ps1 iteration order for ties).
 */
export function topRouteCandidates(query, manifest, limit) {
    const perRoute = bestScoresPerRoute(query, manifest);
    const index = new Map(manifest.routes.map((r, i) => [r.routeId, i]));
    perRoute.sort((a, b) => {
        if (b.score !== a.score)
            return b.score - a.score;
        return (index.get(a.routeId) ?? 0) - (index.get(b.routeId) ?? 0);
    });
    return perRoute.slice(0, Math.max(1, limit));
}
function confidenceFromCandidates(query, candidates) {
    const primary = candidates[0];
    const secondary = candidates[1];
    const normalizedQuery = normalizeText(query);
    const hasCoordinator = /\b(and|or|va|hoac)\b/.test(normalizedQuery);
    if (!primary) {
        return {
            confidence: "low",
            clarificationNeeded: true,
            clarificationReason: "No route produced a confident match."
        };
    }
    if (!secondary) {
        if (primary.score >= 1008 || primary.score >= 25)
            return { confidence: "high", clarificationNeeded: false };
        if (primary.score >= 20)
            return { confidence: "medium", clarificationNeeded: false };
        return {
            confidence: "low",
            clarificationNeeded: true,
            clarificationReason: "Only a weak lexical route match was found."
        };
    }
    const scoreGap = primary.score - secondary.score;
    if (hasCoordinator && secondary.score >= 18) {
        return {
            confidence: "low",
            clarificationNeeded: true,
            clarificationReason: `The query mixes multiple intent cues and top routes remain plausible (${primary.routeId}: ${primary.score}, ${secondary.routeId}: ${secondary.score}).`
        };
    }
    if ((primary.score >= 1008 && scoreGap >= 6) || (primary.score >= 25 && scoreGap >= 12)) {
        return { confidence: "high", clarificationNeeded: false };
    }
    if (primary.score >= 20 && scoreGap >= 8) {
        return { confidence: "medium", clarificationNeeded: false };
    }
    return {
        confidence: "low",
        clarificationNeeded: true,
        clarificationReason: `Top route candidates are close in score (${primary.routeId}: ${primary.score}, ${secondary.routeId}: ${secondary.score}).`
    };
}
export function analyzeRouteResolution(query, manifest) {
    const match = resolveRoute(query, manifest);
    const topCandidates = topRouteCandidates(query, manifest, 5);
    const confidence = confidenceFromCandidates(query, topCandidates);
    return {
        match,
        topCandidates,
        confidence: confidence.confidence,
        clarificationNeeded: confidence.clarificationNeeded,
        clarificationReason: confidence.clarificationReason
    };
}
/**
 * Parity with `prompt-cli.ps1` Resolve-RouteFromQuery: nested routes × patterns, strict score greater-than replacement.
 */
export function resolveRoute(query, manifest) {
    let bestRoute;
    let bestPattern = "";
    let bestScore = -1;
    for (const route of manifest.routes) {
        for (const pattern of route.queryPatterns) {
            const score = scorePattern(query, pattern);
            if (score > bestScore) {
                bestScore = score;
                bestRoute = route;
                bestPattern = pattern;
            }
        }
    }
    if (!bestRoute || bestScore <= 0) {
        throw new Error(`Could not resolve route from query: ${query}`);
    }
    return { route: bestRoute, matchedPattern: bestPattern, score: bestScore };
}

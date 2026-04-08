import { normalizeText } from "./normalize.js";
import type { ExecutionPolicy, NeedLevel, RouteDef } from "./types.js";

const MEMORY_FILE_MAP = {
  decisions: "docs/ai/03-memory/decisions.md",
  patterns: "docs/ai/03-memory/patterns.md",
  mistakes: "docs/ai/03-memory/mistakes.md",
  glossary: "docs/ai/03-memory/glossary.md",
  modules: "docs/ai/03-memory/modules.md"
} as const;

const CURRENT_FACT_SIGNALS = [
  "latest",
  "current",
  "today",
  "version",
  "release note",
  "release notes",
  "changelog",
  "official docs",
  "official doc",
  "documentation",
  "compare package",
  "best package",
  "benchmark"
];

const INTERNAL_CONTEXT_SIGNALS = [
  "mcp",
  "connector",
  "schema",
  "figma",
  "ticket",
  "tickets",
  "issue tracker",
  "internal docs",
  "workspace data",
  "repo data",
  "repository data"
];

const MODULE_SIGNALS = [
  "architecture",
  "module",
  "modules",
  "feature",
  "folder structure",
  "boundary",
  "plugin",
  "routing"
];

const MISTAKE_SIGNALS = ["bug", "crash", "regression", "incident", "mistake", "triage"];

function hasSignal(query: string, signals: string[]): boolean {
  const normalized = normalizeText(query);
  if (!normalized) return false;
  return signals.some((signal) => normalized.includes(normalizeText(signal)));
}

function unique(items: string[]): string[] {
  return [...new Set(items)];
}

export function suggestMemoryFiles(route: RouteDef, query: string): string[] {
  const files: string[] = [];

  if (["architecture", "ai-system", "ci-cd", "ba", "flutter-decision"].includes(route.taskType)) {
    files.push(MEMORY_FILE_MAP.decisions);
  }

  if (["code", "architecture", "design", "performance", "test", "ai-system"].includes(route.taskType)) {
    files.push(MEMORY_FILE_MAP.patterns);
  }

  if (
    ["review", "security", "performance", "test"].includes(route.taskType) ||
    route.routeId === "debug-triage" ||
    hasSignal(query, MISTAKE_SIGNALS)
  ) {
    files.push(MEMORY_FILE_MAP.mistakes);
  }

  if (["flutter-decision", "architecture", "ai-system", "ba", "research"].includes(route.taskType)) {
    files.push(MEMORY_FILE_MAP.glossary);
  }

  if (["architecture", "code", "ai-system", "ci-cd"].includes(route.taskType) || hasSignal(query, MODULE_SIGNALS)) {
    files.push(MEMORY_FILE_MAP.modules);
  }

  return unique(files);
}

function hasSkill(route: RouteDef, skillId: string): boolean {
  return route.skills.includes(skillId);
}

function specialistSkillCount(route: RouteDef): number {
  return route.skills.filter(
    (skillId) => !["intent-router", "context-loader", "quality-grader", "source-validator"].includes(skillId)
  ).length;
}

function researchNeeded(route: RouteDef, query: string): NeedLevel {
  if (route.taskType === "research" || hasSkill(route, "source-validator")) return "true";
  if (hasSignal(query, CURRENT_FACT_SIGNALS)) {
    return route.riskLevel === "high" ? "true" : "optional";
  }
  if (
    [
      "package-selection",
      "plugin-authoring",
      "pipeline-change",
      "security-audit",
      "security-implement",
      "prompt-system-roadmap",
      "agent-system-roadmap",
      "eval-system-roadmap"
    ].includes(route.routeId)
  ) {
    return "optional";
  }
  return "false";
}

function mcpNeeded(route: RouteDef, query: string): NeedLevel {
  if (hasSignal(query, INTERNAL_CONTEXT_SIGNALS)) {
    return hasSkill(route, "mcp-orchestrator") ? "true" : "optional";
  }
  if (hasSkill(route, "mcp-orchestrator")) return "optional";
  return "false";
}

function multiAgentMode(route: RouteDef): ExecutionPolicy["multiAgentMode"] {
  if (route.routeId === "agent-system-roadmap") return "recommended";
  const count = specialistSkillCount(route);
  if (count >= 4) return "consider";
  if (route.riskLevel === "high" && ["architecture", "security", "performance", "test", "ai-system"].includes(route.taskType) && count >= 3) {
    return "consider";
  }
  return "off";
}

function memoryWrite(route: RouteDef, selectedMemoryFiles: string[]): ExecutionPolicy["memoryWrite"] {
  if (selectedMemoryFiles.length > 0) return "enabled";
  if (
    ["architecture", "ai-system", "ba", "ci-cd"].includes(route.taskType) ||
    [
      "state-management-decision",
      "package-selection",
      "code-organization-decision",
      "module-design-decision",
      "pattern-selection",
      "plugin-authoring",
      "offline-sync-strategy",
      "web-desktop-strategy",
      "add-to-app"
    ].includes(route.routeId)
  ) {
    return "likely";
  }
  return "optional";
}

export function decideExecutionPolicy(route: RouteDef, query: string, selectedMemoryFiles: string[] = []): ExecutionPolicy {
  const suggestedMemoryFiles = suggestMemoryFiles(route, query);
  return {
    researchNeeded: researchNeeded(route, query),
    mcpNeeded: mcpNeeded(route, query),
    multiAgentMode: multiAgentMode(route),
    memoryWrite: memoryWrite(route, selectedMemoryFiles),
    suggestedMemoryFiles
  };
}

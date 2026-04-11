import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

export interface ArtifactVerificationResult {
  contractId: string;
  ok: boolean;
  errors: string[];
  sectionOrder: string[];
}

interface ParsedSections {
  sectionOrder: string[];
  sectionContent: Map<string, string>;
  duplicates: string[];
}

interface ContractSpec {
  requiredSections?: string[];
  validateSections?: (sections: Map<string, string>) => string[];
}

interface SchemaContractEntry {
  markdownSections?: string[];
}

const REVIEW_SEVERITY_ORDER = ["critical", "high", "medium", "low"] as const;
const REVIEW_SEVERITY_RANK = new Map(REVIEW_SEVERITY_ORDER.map((severity, index) => [severity, index] as const));

function loadSchemaBackedSections(): Record<string, string[]> {
  const here = dirname(fileURLToPath(import.meta.url));
  const schemaPath = join(here, "..", "..", "..", "docs", "ai", "core", "contracts", "structured-output-schemas.json");
  const document = JSON.parse(readFileSync(schemaPath, "utf8")) as { contracts?: Record<string, SchemaContractEntry> };
  const result: Record<string, string[]> = {};
  for (const [contractId, entry] of Object.entries(document.contracts ?? {})) {
    if (entry.markdownSections?.length) {
      result[contractId] = entry.markdownSections;
    }
  }
  return result;
}

const SCHEMA_BACKED_SECTIONS = loadSchemaBackedSections();

const CONTRACT_SPECS: Record<string, ContractSpec> = {
  "design-spec-v1": {},
  "architecture-decision-v1": {
    validateSections: (sections) => {
      const errors: string[] = [];
      if (!hasListLikeContent(sections.get("Options") ?? "", 2)) {
        errors.push("Options must compare at least 2 concrete choices.");
      }
      if (!hasOrderedList(sections.get("Migration Plan") ?? "")) {
        errors.push("Migration Plan must use an ordered list.");
      }
      return errors;
    }
  },
  "decision-matrix-v1": {
    validateSections: (sections) => {
      const optionMatrix = sections.get("Option Matrix") ?? "";
      if (!hasListLikeContent(optionMatrix, 2)) {
        return ["Option Matrix must compare at least 2 realistic options."];
      }
      return [];
    }
  },
  "implementation-plan-v1": {
    validateSections: (sections) => {
      const errors: string[] = [];
      if (!hasListLikeContent(sections.get("Target Files") ?? "", 1) && !containsLikelyFilePath(sections.get("Target Files") ?? "")) {
        errors.push("Target Files must name at least 1 file or module.");
      }
      if (!hasOrderedList(sections.get("Implementation Steps") ?? "")) {
        errors.push("Implementation Steps must use an ordered list.");
      }
      if (!containsTestLevel(sections.get("Tests") ?? "")) {
        errors.push("Tests must name at least 1 concrete test level.");
      }
      return errors;
    }
  },
  "review-report-v1": {
    validateSections: (sections) => validateReviewReport(sections.get("Findings") ?? "")
  },
  "test-plan-v1": {
    validateSections: (sections) => {
      if (!hasListLikeContent(sections.get("Test Matrix") ?? "", 1)) {
        return ["Test Matrix must map scenarios using a list or table."];
      }
      return [];
    }
  },
  "pipeline-change-v1": {
    validateSections: (sections) => {
      const errors: string[] = [];
      if (!hasOrderedList(sections.get("Target Pipeline") ?? "")) {
        errors.push("Target Pipeline must describe jobs in execution order.");
      }
      if (!hasOrderedList(sections.get("Validation Steps") ?? "")) {
        errors.push("Validation Steps must use an ordered list.");
      }
      return errors;
    }
  },
  "research-brief-v1": {
    validateSections: (sections) => {
      const errors: string[] = [];
      if (!hasListLikeContent(sections.get("Sources") ?? "", 1)) {
        errors.push("Sources must include at least 1 cited source entry.");
      }
      if (!hasListLikeContent(sections.get("Comparison") ?? "", 1)) {
        errors.push("Comparison must use a list or table.");
      }
      return errors;
    }
  },
  "ba-to-design-contract-v1": {},
  "improvement-roadmap-v1": {
    validateSections: (sections) => {
      const errors: string[] = [];
      if (!hasOrderedList(sections.get("Iterations") ?? "")) {
        errors.push("Iterations must use an ordered list.");
      }
      if (!hasListLikeContent(sections.get("Task Backlog") ?? "", 1)) {
        errors.push("Task Backlog must contain actionable backlog items.");
      }
      if (!hasListLikeContent(sections.get("Review Gates") ?? "", 1)) {
        errors.push("Review Gates must contain explicit checks.");
      }
      return errors;
    }
  }
};

function parseTopLevelSections(markdown: string): ParsedSections {
  const sectionOrder: string[] = [];
  const sectionContent = new Map<string, string>();
  const duplicates: string[] = [];
  const lines = markdown.split(/\r?\n/);
  let inCodeFence = false;
  let currentSection: string | null = null;
  let buffer: string[] = [];

  function flushSection(): void {
    if (!currentSection) return;
    const content = buffer.join("\n").trim();
    if (sectionContent.has(currentSection)) {
      duplicates.push(currentSection);
    } else {
      sectionContent.set(currentSection, content);
      sectionOrder.push(currentSection);
    }
    currentSection = null;
    buffer = [];
  }

  for (const line of lines) {
    if (line.trimStart().startsWith("```")) {
      inCodeFence = !inCodeFence;
      if (currentSection) {
        buffer.push(line);
      }
      continue;
    }

    if (!inCodeFence && line.startsWith("## ")) {
      flushSection();
      currentSection = line.slice(3).trim();
      continue;
    }

    if (currentSection) {
      buffer.push(line);
    }
  }

  flushSection();
  return { sectionOrder, sectionContent, duplicates };
}

function hasMeaningfulContent(content: string | undefined): boolean {
  if (!content) return false;
  return content.trim().length > 0;
}

function countListItems(content: string): number {
  return content.split(/\r?\n/).filter((line) => /^\s*(?:-|\*|\d+\.)\s+\S/.test(line)).length;
}

function countTableRows(content: string): number {
  return content.split(/\r?\n/).filter((line) => /^\s*\|.+\|\s*$/.test(line)).length;
}

function hasListLikeContent(content: string, minimumItems: number): boolean {
  return countListItems(content) >= minimumItems || countTableRows(content) >= minimumItems;
}

function hasOrderedList(content: string): boolean {
  return /^\s*\d+\.\s+\S/m.test(content);
}

function containsLikelyFilePath(content: string): boolean {
  return /(?:^|\s)(?:lib|test|docs|tools|android|ios|web)\/[^\s`]+/m.test(content.replace(/\\/g, "/"));
}

function containsTestLevel(content: string): boolean {
  return /\b(unit|widget|integration|golden|smoke|e2e|end-to-end|semantics)\b/i.test(content);
}

interface ReviewFinding {
  severity: string;
  title?: string;
  impact?: string;
  evidence?: string;
  recommendation?: string;
}

function parseReviewFindings(findingsSection: string): ReviewFinding[] {
  const findings: ReviewFinding[] = [];
  let current: ReviewFinding | null = null;

  for (const rawLine of findingsSection.split(/\r?\n/)) {
    const line = rawLine.trimEnd();
    const severityMatch = line.match(/^\s*-\s+severity:\s*(.+)\s*$/i);
    if (severityMatch) {
      current = { severity: severityMatch[1].trim().toLowerCase() };
      findings.push(current);
      continue;
    }

    const fieldMatch = line.match(/^\s+(title|impact|evidence|recommendation):\s*(.+)\s*$/i);
    if (fieldMatch && current) {
      const field = fieldMatch[1].toLowerCase() as keyof ReviewFinding;
      current[field] = fieldMatch[2].trim();
    }
  }

  return findings;
}

function validateReviewReport(findingsSection: string): string[] {
  const trimmed = findingsSection.trim();
  if (!trimmed || trimmed.toLowerCase() === "none") {
    return [];
  }

  const findings = parseReviewFindings(findingsSection);
  if (findings.length === 0) {
    return ["Findings must contain at least 1 structured finding or `none`."];
  }

  const errors: string[] = [];
  let previousRank = -1;
  findings.forEach((finding, index) => {
    const prefix = `Findings item ${index + 1}`;
    const rank = REVIEW_SEVERITY_RANK.get(finding.severity as (typeof REVIEW_SEVERITY_ORDER)[number]);
    if (rank === undefined) {
      errors.push(`${prefix} has invalid severity "${finding.severity}".`);
    } else {
      if (rank < previousRank) {
        errors.push("Findings severities must be ordered from highest to lowest.");
      }
      previousRank = rank;
    }

    if (!finding.title) errors.push(`${prefix} is missing title.`);
    if (!finding.impact) errors.push(`${prefix} is missing impact.`);
    if (!finding.evidence) errors.push(`${prefix} is missing evidence.`);
    if (!finding.recommendation) errors.push(`${prefix} is missing recommendation.`);
  });

  return errors;
}

export function verifyArtifactMarkdown(markdown: string, contractId: string): ArtifactVerificationResult {
  const spec = CONTRACT_SPECS[contractId];
  const requiredSections = spec?.requiredSections ?? SCHEMA_BACKED_SECTIONS[contractId];

  if (!spec && !requiredSections) {
    return {
      contractId,
      ok: false,
      errors: [`Unsupported output contract: ${contractId}`],
      sectionOrder: []
    };
  }

  const parsed = parseTopLevelSections(markdown);
  const errors: string[] = [];

  if (parsed.duplicates.length > 0) {
    errors.push(`Duplicate top-level sections: ${parsed.duplicates.join(", ")}`);
  }

  const unexpectedSections = parsed.sectionOrder.filter((name) => !requiredSections.includes(name));
  if (unexpectedSections.length > 0) {
    errors.push(`Unexpected top-level sections: ${unexpectedSections.join(", ")}`);
  }

  const missingSections = requiredSections.filter((name) => !parsed.sectionContent.has(name));
  if (missingSections.length > 0) {
    errors.push(`Missing required sections: ${missingSections.join(", ")}`);
  }

  const presentRequiredSections = parsed.sectionOrder.filter((name) => requiredSections.includes(name));
  if (
    missingSections.length === 0 &&
    unexpectedSections.length === 0 &&
    presentRequiredSections.some((name, index) => name !== requiredSections[index])
  ) {
    errors.push(`Top-level sections must follow this order: ${requiredSections.join(" -> ")}`);
  }

  for (const sectionName of requiredSections) {
    const content = parsed.sectionContent.get(sectionName);
    if (!hasMeaningfulContent(content)) {
      errors.push(`Section "${sectionName}" must not be empty.`);
    }
  }

  if (spec?.validateSections) {
    errors.push(...spec.validateSections(parsed.sectionContent));
  }

  return {
    contractId,
    ok: errors.length === 0,
    errors,
    sectionOrder: parsed.sectionOrder
  };
}

export function supportedContracts(): string[] {
  return [...new Set([...Object.keys(CONTRACT_SPECS), ...Object.keys(SCHEMA_BACKED_SECTIONS)])];
}

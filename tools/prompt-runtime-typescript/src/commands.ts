import type { CommandPolicy, RouteDef, RuntimeCommand } from "./types.js";

export const COMMAND_POLICIES: CommandPolicy[] = [
  {
    command: "ask",
    preferredTaskTypes: ["research", "flutter-decision", "ai-system", "design"],
    preferredContracts: ["research-brief-v1", "decision-matrix-v1", "design-spec-v1"]
  },
  {
    command: "plan",
    preferredTaskTypes: ["architecture", "ai-system", "ba", "design", "flutter-decision", "code"],
    preferredContracts: [
      "architecture-decision-v1",
      "improvement-roadmap-v1",
      "implementation-plan-v1",
      "design-spec-v1",
      "decision-matrix-v1",
      "test-plan-v1"
    ]
  },
  {
    command: "review",
    preferredTaskTypes: ["review", "security", "performance", "test", "architecture"],
    preferredContracts: ["review-report-v1", "test-plan-v1", "architecture-decision-v1"]
  },
  {
    command: "execute",
    preferredTaskTypes: ["code", "security", "performance", "test", "ci-cd", "architecture"],
    preferredContracts: ["implementation-plan-v1", "pipeline-change-v1", "architecture-decision-v1"]
  },
  {
    command: "ship-check",
    preferredTaskTypes: ["ci-cd", "test", "security", "performance", "architecture"],
    preferredContracts: ["pipeline-change-v1", "review-report-v1", "test-plan-v1", "architecture-decision-v1"]
  }
];

/**
 * Heuristic alignment between CLI command mode and resolved route (hints only; routing stays pattern-based).
 */
export function evaluateCommandRouteAlignment(
  command: RuntimeCommand,
  route: RouteDef
): { warnings: string[]; hints: string[] } {
  const policy = COMMAND_POLICIES.find((p) => p.command === command);
  if (!policy) {
    return { warnings: [], hints: [] };
  }

  const warnings: string[] = [];
  const hints: string[] = [];

  if (!policy.preferredTaskTypes.includes(route.taskType)) {
    warnings.push(
      `Command "${command}" often works with task types [${policy.preferredTaskTypes.join(", ")}]; this route is taskType="${route.taskType}".`
    );
  } else {
    hints.push(`taskType "${route.taskType}" fits command "${command}".`);
  }

  if (!policy.preferredContracts.includes(route.outputContract)) {
    warnings.push(
      `Command "${command}" often pairs with contracts [${policy.preferredContracts.join(", ")}]; this route uses "${route.outputContract}".`
    );
  } else {
    hints.push(`output contract "${route.outputContract}" fits command "${command}".`);
  }

  return { warnings, hints };
}

export function parseCommand(input: string): RuntimeCommand {
  const value = input.trim() as RuntimeCommand;
  if (!COMMAND_POLICIES.some((p) => p.command === value)) {
    throw new Error(`Unsupported command: ${input}`);
  }
  return value;
}

export type RiskLevel = "low" | "medium" | "high";
export type NeedLevel = "false" | "optional" | "true";
export type MultiAgentMode = "off" | "consider" | "recommended";
export type MemoryWriteMode = "optional" | "likely" | "enabled";
export type RoutingConfidence = "high" | "medium" | "low";

export interface RouteDef {
  routeId: string;
  taskType: string;
  primaryIntent: string;
  outputContract: string;
  taskPrompt: string;
  skills: string[];
  riskLevel: RiskLevel;
  queryPatterns: string[];
  contextFiles?: string[];
}

export interface RoutesManifest {
  routes: RouteDef[];
}

export interface RouteMatch {
  route: RouteDef;
  matchedPattern: string;
  score: number;
}

export type RuntimeCommand =
  | "ask"
  | "plan"
  | "review"
  | "execute"
  | "ship-check";

export interface CommandPolicy {
  command: RuntimeCommand;
  preferredTaskTypes: string[];
  preferredContracts: string[];
}

export interface RuntimeExplain {
  topCandidates: Array<{ routeId: string; score: number; matchedPattern: string }>;
  commandAlignment: {
    warnings: string[];
    hints: string[];
  };
  routeConfidence: {
    level: RoutingConfidence;
    clarificationNeeded: boolean;
    clarificationReason?: string;
  };
}

export interface ExecutionPolicy {
  researchNeeded: NeedLevel;
  mcpNeeded: NeedLevel;
  multiAgentMode: MultiAgentMode;
  memoryWrite: MemoryWriteMode;
  suggestedMemoryFiles: string[];
}

export interface RuntimeResult {
  command: RuntimeCommand;
  routeId: string;
  outputContract: string;
  riskLevel: RiskLevel;
  routeConfidence: RoutingConfidence;
  clarificationNeeded: boolean;
  clarificationReason?: string;
  skills: string[];
  matchedPattern: string;
  executionPolicy: ExecutionPolicy;
  explain?: RuntimeExplain;
}

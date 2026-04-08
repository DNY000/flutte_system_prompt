export type RiskLevel = "low" | "medium" | "high";

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
}

export interface RuntimeResult {
  command: RuntimeCommand;
  routeId: string;
  outputContract: string;
  riskLevel: RiskLevel;
  skills: string[];
  matchedPattern: string;
  explain?: RuntimeExplain;
}

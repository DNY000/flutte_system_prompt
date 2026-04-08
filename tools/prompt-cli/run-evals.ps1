[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$routesPath = Join-Path $PSScriptRoot 'routes.json'
$contractsPath = Join-Path $RepoRoot 'docs\ai\00-core\output-contracts.md'
$routeEvalPath = Join-Path $PSScriptRoot 'evals\route-regression.json'
$contractEvalPath = Join-Path $PSScriptRoot 'evals\contract-compliance.json'
$multiEvalPath = Join-Path $PSScriptRoot 'evals\multilingual-routing-benchmark.json'
$thresholdPath = Join-Path $PSScriptRoot 'evals\quality-thresholds.json'
$baselinePath = Join-Path $PSScriptRoot 'evals\trend-baseline.json'
$routerScript = Join-Path $PSScriptRoot 'aiprompt.ps1'

function Parse-ContractMapFromMarkdown {
    param([string]$FilePath)

    $content = Get-Content -LiteralPath $FilePath -Raw
    $lines = $content -split "`r?`n"
    $map = @{}

    foreach ($line in $lines) {
        if ($line -match '^\|\s*`([^`]+)`\s*\|\s*`([^`]+)`\s*\|$') {
            $routeId = $matches[1]
            $contract = $matches[2]
            $map[$routeId] = $contract
        }
    }

    return $map
}

function Resolve-RouteId {
    param([string]$Query)

    $raw = & $routerScript resolve -Query $Query -Json
    if ($LASTEXITCODE -ne 0) {
        throw "Resolve failed for query: $Query"
    }

    $obj = $raw | ConvertFrom-Json
    return $obj.routeId
}

$routesManifest = Get-Content -LiteralPath $routesPath -Raw | ConvertFrom-Json
$routeEval = Get-Content -LiteralPath $routeEvalPath -Raw | ConvertFrom-Json
$contractEval = Get-Content -LiteralPath $contractEvalPath -Raw | ConvertFrom-Json
$multiEval = Get-Content -LiteralPath $multiEvalPath -Raw | ConvertFrom-Json
$thresholds = Get-Content -LiteralPath $thresholdPath -Raw | ConvertFrom-Json
$baseline = Get-Content -LiteralPath $baselinePath -Raw | ConvertFrom-Json
$contractMap = Parse-ContractMapFromMarkdown -FilePath $contractsPath
$routeMap = @{}
foreach ($route in $routesManifest.routes) {
    $routeMap[$route.routeId] = $route.outputContract
}

$failures = New-Object System.Collections.Generic.List[string]

foreach ($c in $routeEval.cases) {
    $actual = Resolve-RouteId -Query $c.query
    if ($actual -ne $c.expectedRouteId) {
        $failures.Add("route-regression: query='$($c.query)' expected='$($c.expectedRouteId)' actual='$actual'")
    }
}

foreach ($c in $multiEval.cases) {
    $actual = Resolve-RouteId -Query $c.query
    if ($actual -ne $c.expectedRouteId) {
        $failures.Add("multilingual-routing: query='$($c.query)' expected='$($c.expectedRouteId)' actual='$actual'")
    }
}

foreach ($c in $contractEval.routes) {
    if (-not $routeMap.ContainsKey($c.routeId)) {
        $failures.Add("contract-compliance: missing route in routes.json '$($c.routeId)'")
        continue
    }

    $actual = $routeMap[$c.routeId]
    if ($actual -ne $c.expectedContract) {
        $failures.Add("contract-compliance: route='$($c.routeId)' expected='$($c.expectedContract)' actual='$actual'")
    }

    if ($contractMap.ContainsKey($c.routeId)) {
        $docContract = $contractMap[$c.routeId]
        if ($docContract -ne $c.expectedContract) {
            $failures.Add("contract-doc-sync: route='$($c.routeId)' expected='$($c.expectedContract)' doc='$docContract'")
        }
    }
    else {
        $failures.Add("contract-doc-sync: missing route in output-contracts.md '$($c.routeId)'")
    }
}

if ($thresholds.defaultThreshold -lt 0 -or $thresholds.defaultThreshold -gt 4) {
    $failures.Add("quality-thresholds: defaultThreshold must be between 0 and 4")
}
if ($thresholds.minimumCriterionFloor -lt 0 -or $thresholds.minimumCriterionFloor -gt 4) {
    $failures.Add("quality-thresholds: minimumCriterionFloor must be between 0 and 4")
}
if (-not $baseline.currentVersion) {
    $failures.Add("trend-baseline: currentVersion is required")
}

if ($failures.Count -gt 0) {
    Write-Output "Prompt evals: FAILED"
    $failures | ForEach-Object { Write-Output "- $_" }
    exit 1
}

Write-Output "Prompt evals: PASSED"
Write-Output "- route regression (one golden query per route where applicable): $($routeEval.cases.Count) cases"
Write-Output "- multilingual routing: $($multiEval.cases.Count) cases"
Write-Output "- contract compliance: $($contractEval.routes.Count) checks"
Write-Output "- quality thresholds and trend baseline: validated"
Write-Output "- note: run 'npm run validate-manifest' in tools/prompt-runtime-ts (also on CI) for manifest/file/docs sync"

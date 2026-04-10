[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$routesPath = Join-Path $PSScriptRoot 'routes.json'
$contractsPath = Join-Path $RepoRoot 'docs\ai\core\contracts\output-contracts.md'
$routeEvalPath = Join-Path $PSScriptRoot 'evals\route-regression.json'
$contractEvalPath = Join-Path $PSScriptRoot 'evals\contract-compliance.json'
$multiEvalPath = Join-Path $PSScriptRoot 'evals\multilingual-routing-benchmark.json'
$outputArtifactEvalPath = Join-Path $PSScriptRoot 'evals\output-artifact-regression.json'
$buildSmokePath = Join-Path $PSScriptRoot 'evals\build-smoke.json'
$thresholdPath = Join-Path $PSScriptRoot 'evals\quality-thresholds.json'
$baselinePath = Join-Path $PSScriptRoot 'evals\trend-baseline.json'
$routerScript = Join-Path $PSScriptRoot 'prompt-cli.ps1'

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
    $exitCodeVar = Get-Variable -Name LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue
    $exitCode = if ($null -ne $exitCodeVar) { [int]$exitCodeVar.Value } else { 0 }
    if ($exitCode -ne 0) {
        throw "Resolve failed for query: $Query"
    }

    $obj = $raw | ConvertFrom-Json
    return $obj.routeId
}

function Invoke-OutputArtifactVerification {
    param([string]$RepoRootValue)

    $runtimeDir = Join-Path $RepoRootValue 'tools\prompt-runtime-typescript'
    $output = & npm --prefix $runtimeDir run verify-artifacts 2>&1
    $exitCodeVar = Get-Variable -Name LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue
    $exitCode = if ($null -ne $exitCodeVar) { [int]$exitCodeVar.Value } else { 0 }

    if ($output) {
        $output | ForEach-Object { Write-Output $_ }
    }

    if ($exitCode -ne 0) {
        throw "npm run verify-artifacts failed"
    }
}

function Invoke-PromptBuildSmoke {
    param([string]$SuitePath)

    $suite = Get-Content -LiteralPath $SuitePath -Raw | ConvertFrom-Json
    $failures = New-Object System.Collections.Generic.List[string]

    foreach ($case in $suite.cases) {
        $raw = & $routerScript build -Query $case.query -Goal $case.goal
        $exitCodeVar = Get-Variable -Name LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue
        $exitCode = if ($null -ne $exitCodeVar) { [int]$exitCodeVar.Value } else { 0 }

        if ($exitCode -ne 0) {
            $failures.Add("prompt-build-smoke: case='$($case.caseId)' build command failed")
            continue
        }

        foreach ($expectedFragment in @($case.mustContain)) {
            if ($raw -notmatch [regex]::Escape($expectedFragment)) {
                $failures.Add("prompt-build-smoke: case='$($case.caseId)' missing fragment '$expectedFragment'")
            }
        }
    }

    return @($failures)
}

$routesManifest = Get-Content -LiteralPath $routesPath -Raw | ConvertFrom-Json
$routeEval = Get-Content -LiteralPath $routeEvalPath -Raw | ConvertFrom-Json
$contractEval = Get-Content -LiteralPath $contractEvalPath -Raw | ConvertFrom-Json
$multiEval = Get-Content -LiteralPath $multiEvalPath -Raw | ConvertFrom-Json
$outputArtifactEval = Get-Content -LiteralPath $outputArtifactEvalPath -Raw | ConvertFrom-Json
$buildSmoke = Get-Content -LiteralPath $buildSmokePath -Raw | ConvertFrom-Json
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
if ($null -ne $baseline.metrics.outputArtifactVerificationPassRate -and ($baseline.metrics.outputArtifactVerificationPassRate -lt 0 -or $baseline.metrics.outputArtifactVerificationPassRate -gt 1)) {
    $failures.Add("trend-baseline: outputArtifactVerificationPassRate must be between 0 and 1")
}

try {
    Invoke-OutputArtifactVerification -RepoRootValue $RepoRoot
}
catch {
    $failures.Add("output-artifact-verification: $($_.Exception.Message)")
}

try {
    @(Invoke-PromptBuildSmoke -SuitePath $buildSmokePath) | ForEach-Object { $failures.Add($_) }
}
catch {
    $failures.Add("prompt-build-smoke: $($_.Exception.Message)")
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
Write-Output "- generated output artifact verification: $($outputArtifactEval.cases.Count) cases"
Write-Output "- prompt build smoke: $($buildSmoke.cases.Count) cases"
Write-Output "- quality thresholds and trend baseline: validated"
Write-Output "- note: run 'npm run validate-manifest' in tools/prompt-runtime-typescript (also on CI) for manifest/file/docs sync"

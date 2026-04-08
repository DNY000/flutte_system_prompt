[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet('help', 'list-routes', 'resolve', 'show-route', 'build')]
    [string]$Command = 'help',

    [string]$RouteId,
    [string]$Query,
    [string]$Goal,
    [string]$Scope,
    [string[]]$Related,
    [string[]]$Constraints,
    [string[]]$DefinitionOfDone,
    [string[]]$ExtraContextFiles,
    [ValidateSet('none', 'decisions', 'patterns', 'mistakes', 'all')]
    [string[]]$Memory = @('none'),
    [switch]$SkipProjectContext,
    [switch]$IncludeReferences,
    [string]$OutputPath,
    [switch]$Clipboard,
    [switch]$Json
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$script:DocsRoot = Join-Path $script:RepoRoot 'docs\ai'
$script:ManifestPath = Join-Path $PSScriptRoot 'routes.json'
$script:DomainManifestPath = Join-Path $PSScriptRoot 'flutter-domains.json'

function Get-FileText {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    $path = Join-Path $script:RepoRoot $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Missing file: $path"
    }

    return Get-Content -LiteralPath $path -Raw
}

function Get-Manifest {
    if (-not (Test-Path -LiteralPath $script:ManifestPath)) {
        throw "Missing manifest: $script:ManifestPath"
    }

    return Get-Content -LiteralPath $script:ManifestPath -Raw | ConvertFrom-Json
}

function Get-DomainManifest {
    if (-not (Test-Path -LiteralPath $script:DomainManifestPath)) {
        throw "Missing domain manifest: $script:DomainManifestPath"
    }

    return Get-Content -LiteralPath $script:DomainManifestPath -Raw | ConvertFrom-Json
}

function Normalize-Text {
    param(
        [AllowEmptyString()]
        [string]$Text
    )

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return ''
    }

    $formD = $Text.Normalize([Text.NormalizationForm]::FormD)
    $builder = New-Object System.Text.StringBuilder

    foreach ($char in $formD.ToCharArray()) {
        $category = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($char)
        if ($category -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$builder.Append($char)
        }
    }

    $normalized = $builder.ToString().Normalize([Text.NormalizationForm]::FormC).ToLowerInvariant()
    $normalized = [regex]::Replace($normalized, '[^a-z0-9]+', ' ')
    return $normalized.Trim()
}

function Get-RouteById {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RouteIdValue,
        [Parameter(Mandatory = $true)]
        $Manifest
    )

    foreach ($route in $Manifest.routes) {
        if ($route.routeId -eq $RouteIdValue) {
            return $route
        }
    }

    throw "Unknown route_id: $RouteIdValue"
}

function Resolve-RouteFromQuery {
    param(
        [Parameter(Mandatory = $true)]
        [string]$QueryValue,
        [Parameter(Mandatory = $true)]
        $Manifest
    )

    $normalizedQuery = Normalize-Text -Text $QueryValue
    $queryTokens = @($normalizedQuery -split '\s+' | Where-Object { $_ })

    $best = $null
    $bestScore = -1
    $bestPattern = $null

    foreach ($route in $Manifest.routes) {
        foreach ($pattern in $route.queryPatterns) {
            $normalizedPattern = Normalize-Text -Text $pattern
            $patternTokens = @($normalizedPattern -split '\s+' | Where-Object { $_ })
            $matchedTokens = @($patternTokens | Where-Object { $queryTokens -contains $_ })
            $score = 0

            if ($normalizedQuery.Contains($normalizedPattern)) {
                $score = 1000 + $normalizedPattern.Length
            }
            elseif ($matchedTokens.Count -gt 0) {
                $score = ($matchedTokens.Count * 10) - ($patternTokens.Count - $matchedTokens.Count)
            }

            if ($score -gt $bestScore) {
                $best = $route
                $bestScore = $score
                $bestPattern = $pattern
            }
        }
    }

    if ($null -eq $best -or $bestScore -le 0) {
        throw "Could not resolve a route from query: $QueryValue"
    }

    return [pscustomobject]@{
        route = $best
        score = $bestScore
        matchedPattern = $bestPattern
    }
}

function Get-MarkdownSection {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RelativePath,
        [Parameter(Mandatory = $true)]
        [string]$HeaderText
    )

    $content = Get-FileText -RelativePath $RelativePath
    $heading = '## `' + $HeaderText + '`'
    $escapedHeading = [regex]::Escape($heading)
    $pattern = '(?ms)^' + $escapedHeading + '.*?(?=^## |\z)'
    $match = [regex]::Match($content, $pattern)

    if (-not $match.Success) {
        throw "Could not find heading '$HeaderText' in $RelativePath"
    }

    return $match.Value.Trim()
}

function Resolve-FlutterDomains {
    param(
        [AllowEmptyString()]
        [string]$QueryValue,
        [Parameter(Mandatory = $true)]
        $Route,
        [Parameter(Mandatory = $true)]
        $DomainManifest
    )

    $normalizedQuery = Normalize-Text -Text $QueryValue
    $queryTokens = @($normalizedQuery -split '\s+' | Where-Object { $_ })
    $scoredDomains = @()
    $routeHintMatched = @()

    foreach ($domain in $DomainManifest.domains) {
        $queryScore = 0
        $routeHintScore = 0

        if (@($domain.routeHints) -contains $Route.routeId) {
            $routeHintScore = 10
        }

        foreach ($pattern in @($domain.queryPatterns)) {
            $normalizedPattern = Normalize-Text -Text $pattern
            $patternTokens = @($normalizedPattern -split '\s+' | Where-Object { $_ })
            $matchedTokens = @($patternTokens | Where-Object { $queryTokens -contains $_ })

            if ($normalizedQuery -and $normalizedQuery.Contains($normalizedPattern)) {
                $queryScore += 1000 + $normalizedPattern.Length
            }
            elseif ($matchedTokens.Count -gt 0) {
                $queryScore += ($matchedTokens.Count * 5) - ($patternTokens.Count - $matchedTokens.Count)
            }
        }

        $score = $queryScore + $routeHintScore
        if ($score -gt 0) {
            $entry = [pscustomobject]@{
                domainId = $domain.domainId
                sectionId = $domain.sectionId
                sectionIndex = $domain.sectionIndex
                queryScore = $queryScore
                score = $score
                files = @($domain.files)
            }
            $scoredDomains += $entry

            if ($routeHintScore -gt 0) {
                $routeHintMatched += $entry
            }
        }
    }

    $queryMatched = @($scoredDomains | Where-Object { $_.queryScore -gt 0 })
    if ($queryMatched.Count -gt 0) {
        $selectionPool = $queryMatched
    }
    elseif ([string]::IsNullOrWhiteSpace($QueryValue)) {
        $selectionPool = if ($routeHintMatched.Count -eq 1) { $routeHintMatched } else { @() }
    }
    else {
        $selectionPool = $scoredDomains
    }

    $selected = @(
        $selectionPool |
        Sort-Object @{ Expression = 'score'; Descending = $true }, @{ Expression = 'domainId'; Descending = $false } |
        Select-Object -First 2
    )

    $sectionIds = @($selected | ForEach-Object { $_.sectionId } | Where-Object { $_ } | Select-Object -Unique)
    $sectionIndexes = @($selected | ForEach-Object { $_.sectionIndex } | Where-Object { $_ } | Select-Object -Unique)

    if ($selected.Count -eq 0 -and $routeHintMatched.Count -gt 0) {
        $hintSectionIds = @($routeHintMatched | ForEach-Object { $_.sectionId } | Where-Object { $_ } | Select-Object -Unique)
        if ($hintSectionIds.Count -eq 1) {
            $sectionIds = $hintSectionIds
            $sectionIndexes = @($routeHintMatched | ForEach-Object { $_.sectionIndex } | Where-Object { $_ } | Select-Object -Unique)
        }
    }

    return [pscustomobject]@{
        domainIds = @($selected | ForEach-Object { $_.domainId })
        sectionIds = $sectionIds
        sectionIndexes = $sectionIndexes
        files = @($selected | ForEach-Object { $_.files } | Where-Object { $_ } | Select-Object -Unique)
    }
}

function Test-GuidePackSupport {
    param(
        [Parameter(Mandatory = $true)]
        $Route
    )

    return @('flutter-decision', 'architecture', 'test', 'performance', 'security', 'ci-cd') -contains $Route.taskType
}

function Get-SectionExampleFiles {
    param(
        [string[]]$SectionIndexes
    )

    $exampleFiles = @()

    foreach ($sectionIndex in @($SectionIndexes | Where-Object { $_ })) {
        $relativeDirectory = Split-Path -Parent $sectionIndex
        if (-not $relativeDirectory) {
            continue
        }

        $candidateRelative = Join-Path $relativeDirectory 'examples.md'
        $candidateAbsolute = Join-Path $script:RepoRoot $candidateRelative
        if (Test-Path -LiteralPath $candidateAbsolute) {
            $exampleFiles += ($candidateRelative -replace '\\', '/')
        }
    }

    return @($exampleFiles | Select-Object -Unique)
}

function Format-BulletList {
    param(
        [AllowNull()]
        [string[]]$Items
    )

    if ($null -eq $Items -or $Items.Count -eq 0) {
        return "- none"
    }

    return ($Items | ForEach-Object { "- $_" }) -join "`n"
}

function Get-MemoryFiles {
    param(
        [string[]]$Selection
    )

    if ($Selection -contains 'none') {
        return @()
    }

    if ($Selection -contains 'all') {
        return @(
            'docs/ai/03-memory/decisions.md',
            'docs/ai/03-memory/patterns.md',
            'docs/ai/03-memory/mistakes.md'
        )
    }

    $files = @()
    foreach ($item in $Selection) {
        switch ($item) {
            'decisions' { $files += 'docs/ai/03-memory/decisions.md' }
            'patterns' { $files += 'docs/ai/03-memory/patterns.md' }
            'mistakes' { $files += 'docs/ai/03-memory/mistakes.md' }
        }
    }

    return $files
}

function Get-RouteResolutionBlock {
    param(
        [Parameter(Mandatory = $true)]
        $Route,
        [string]$MatchedPattern,
        [string[]]$RequiredContext,
        [string[]]$ExtraFiles,
        [string[]]$MemoryFiles,
        [string[]]$SectionIds,
        [string[]]$DomainIds,
        [bool]$NeedReferences
    )

    $secondaryIntent = 'none'
    $researchNeeded = if ($Route.routeId -eq 'research-brief') { 'true' } else { 'false' }
    $mcpNeeded = 'false'
    $multiAgentMode = 'off'
    $memoryItems = @($MemoryFiles | Where-Object { $_ })
    $extraItems = @($ExtraFiles | Where-Object { $_ })
    $sectionItems = @($SectionIds | Where-Object { $_ })
    $domainItems = @($DomainIds | Where-Object { $_ })
    $requiredContextItems = @($RequiredContext | Where-Object { $_ })
    $memoryWrite = if ($memoryItems.Count -gt 0) { 'enabled' } else { 'optional' }
    $activeSections = if ($sectionItems.Count -gt 0) { $sectionItems -join ', ' } else { 'none' }
    $activePacks = if ($domainItems.Count -gt 0) { $domainItems -join ', ' } else { 'none' }

    if ($extraItems.Count -gt 0) {
        $requiredContextItems += $extraItems
    }

    if ($NeedReferences) {
        $requiredContextItems += 'docs/ai/07-references/source-map.md'
    }

    $contextBlock = Format-BulletList -Items $requiredContextItems
    $skillBlock = Format-BulletList -Items @($Route.skills)

    return @"
Route Resolution
- primary_intent: $($Route.primaryIntent)
- secondary_intents: $secondaryIntent
- route_id: $($Route.routeId)
- output_contract: $($Route.outputContract)
- matched_pattern: $(if ($MatchedPattern) { $MatchedPattern } else { 'manual-route' })
- active_sections: $activeSections
- active_packs: $activePacks
- risk_level: $($Route.riskLevel)
- mcp_needed: $mcpNeeded
- research_needed: $researchNeeded
- multi_agent_mode: $multiAgentMode
- memory_write: $memoryWrite

Required Context
$contextBlock

Required Skills
$skillBlock
"@.Trim()
}

function Build-PromptPackage {
    param(
        [Parameter(Mandatory = $true)]
        $Route,
        [string]$MatchedPattern
    )

    $systemPrompt = Get-FileText -RelativePath 'docs/ai/00-core/system-prompt.md'
    $outputRules = Get-FileText -RelativePath 'docs/ai/00-core/output-rules.md'
    $taskPrompt = Get-FileText -RelativePath $Route.taskPrompt
    $projectContext = if ($SkipProjectContext) { '' } else { Get-FileText -RelativePath 'docs/ai/01-context/project-context.md' }
    $contractRules = Get-MarkdownSection -RelativePath 'docs/ai/00-core/output-contracts.md' -HeaderText $Route.outputContract
    $contractShell = Get-MarkdownSection -RelativePath 'docs/ai/04-templates/contract-shells.md' -HeaderText $Route.outputContract
    $routeContextFiles = @()
    $domainManifest = $null
    $resolvedDomains = [pscustomobject]@{
        domainIds = @()
        sectionIds = @()
        sectionIndexes = @()
        files = @()
    }

    $routeContextFiles += @($Route.contextFiles | Where-Object { $_ })

    if (Test-GuidePackSupport -Route $Route) {
        $domainManifest = Get-DomainManifest
        $resolvedDomains = Resolve-FlutterDomains -QueryValue $Query -Route $Route -DomainManifest $domainManifest
        $routeContextFiles += 'docs/ai/00-core/decision-engine.md'
        $routeContextFiles += 'docs/ai/00-core/self-analysis-protocol.md'
        $routeContextFiles += 'docs/ai/08-guides/flutter-docs/index.md'
        $routeContextFiles += @($resolvedDomains.sectionIndexes)
        $routeContextFiles += @(Get-SectionExampleFiles -SectionIndexes @($resolvedDomains.sectionIndexes))
        $routeContextFiles += @($resolvedDomains.files)
    }

    $routeContextFiles = @($routeContextFiles | Where-Object { $_ } | Select-Object -Unique)

    $routeContextBlocks = @()
    foreach ($routeContextFile in $routeContextFiles) {
        $routeContextBlocks += @"
### $routeContextFile

$(Get-FileText -RelativePath $routeContextFile)
"@
    }

    $memoryFiles = Get-MemoryFiles -Selection $Memory
    $memoryBlocks = @()
    foreach ($memoryFile in $memoryFiles) {
        $memoryBlocks += @"
### $memoryFile

$(Get-FileText -RelativePath $memoryFile)
"@
    }

    $extraBlocks = @()
    foreach ($extraFile in @($ExtraContextFiles | Where-Object { $_ })) {
        $relative = $extraFile.Replace('/', '\')
        $absolute = Join-Path $script:RepoRoot $relative
        if (-not (Test-Path -LiteralPath $absolute)) {
            throw "Missing extra context file: $absolute"
        }

        $extraBlocks += @"
### $relative

$(Get-Content -LiteralPath $absolute -Raw)
"@
    }

    $referencesBlock = if ($IncludeReferences) {
        @"
## Source Map

$(Get-FileText -RelativePath 'docs/ai/07-references/source-map.md')
"@
    }
    else {
        ''
    }

    $requiredContext = @(
        'docs/ai/00-core/system-prompt.md',
        'docs/ai/00-core/output-rules.md',
        $Route.taskPrompt
    )

    if ($routeContextFiles.Count -gt 0) {
        $requiredContext += $routeContextFiles
    }

    if (-not $SkipProjectContext) {
        $requiredContext += 'docs/ai/01-context/project-context.md'
    }

    $routeResolution = Get-RouteResolutionBlock -Route $Route -MatchedPattern $MatchedPattern -RequiredContext $requiredContext -ExtraFiles @($ExtraContextFiles) -MemoryFiles @($memoryFiles) -SectionIds @($resolvedDomains.sectionIds) -DomainIds @($resolvedDomains.domainIds) -NeedReferences $IncludeReferences.IsPresent

    $requestBody = @"
Task Type
- $($Route.taskType)

Requested Route
- $($Route.routeId)

Desired Output Contract
- $($Route.outputContract)

Goal
$(Format-BulletList -Items @($Goal | Where-Object { $_ }))

Scope
$(Format-BulletList -Items @($Scope | Where-Object { $_ }))

Related Files Or Modules
$(Format-BulletList -Items $Related)

Constraints
$(Format-BulletList -Items $Constraints)

Definition Of Done
$(Format-BulletList -Items $DefinitionOfDone)

Original Query
$(Format-BulletList -Items @($Query | Where-Object { $_ }))
"@.Trim()

    $memorySection = if ($memoryBlocks.Count -gt 0) {
        @"
## Memory

$($memoryBlocks -join "`n`n")
"@
    }
    else {
        ''
    }

    $extraContextSection = if ($extraBlocks.Count -gt 0) {
        @"
## Extra Context

$($extraBlocks -join "`n`n")
"@
    }
    else {
        ''
    }

    $projectContextSection = if ($SkipProjectContext) {
        ''
    }
    else {
        @"
## Project Context

$projectContext
"@
    }

    $routeContextSection = if ($routeContextBlocks.Count -gt 0) {
        @"
## Route Context

$($routeContextBlocks -join "`n`n")
"@
    }
    else {
        ''
    }

    return @"
# AI Prompt Package

## Runtime

$routeResolution

## System Prompt

$systemPrompt

## Output Rules

$outputRules
$projectContextSection
$routeContextSection

## Task Prompt

$taskPrompt

## Output Contract

$contractRules

## Output Shell

$contractShell
$memorySection
$extraContextSection
$referencesBlock

## User Request

$requestBody

## Final Instruction

Return only the final answer using contract $($Route.outputContract).
Be direct.
Do not add sections outside the contract.
Do not restate system rules.
"@.Trim() + "`n"
}

function Write-Result {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent) {
            New-Item -ItemType Directory -Force -Path $parent | Out-Null
        }

        Set-Content -LiteralPath $OutputPath -Value $Text -Encoding UTF8
    }

    if ($Clipboard) {
        Set-Clipboard -Value $Text
    }

    $Text
}

function Show-Usage {
    @"
Usage:
  .\aiprompt.ps1 list-routes
  .\aiprompt.ps1 resolve -Query "design giao dien login"
  .\aiprompt.ps1 show-route -RouteId design-screen
  .\aiprompt.ps1 build -RouteId design-screen -Goal "Design login screen"
  .\aiprompt.ps1 build -Query "design giao dien login" -Goal "Design login screen" -OutputPath .out\login-prompt.md

Common options:
  -Related lib/features/auth/presentation/login_screen.dart
  -Constraints "Use Material 3" "Support tablet"
  -DefinitionOfDone "Include empty and error states"
  -ExtraContextFiles docs/ai/06-examples/route-examples.md
  -Memory decisions patterns
  -IncludeReferences
  -Clipboard
"@
}

$manifest = Get-Manifest

switch ($Command) {
    'help' {
        Write-Output (Show-Usage)
        break
    }
    'list-routes' {
        $items = $manifest.routes | Sort-Object routeId | ForEach-Object {
            [pscustomobject]@{
                routeId = $_.routeId
                taskType = $_.taskType
                primaryIntent = $_.primaryIntent
                outputContract = $_.outputContract
            }
        }

        if ($Json) {
            $items | ConvertTo-Json -Depth 5
        }
        else {
            $items | Format-Table -AutoSize | Out-String
        }
        break
    }
    'resolve' {
        if (-not $Query) {
            throw "The resolve command requires -Query."
        }

        $resolved = Resolve-RouteFromQuery -QueryValue $Query -Manifest $manifest
        $result = [pscustomobject]@{
            routeId = $resolved.route.routeId
            taskType = $resolved.route.taskType
            primaryIntent = $resolved.route.primaryIntent
            outputContract = $resolved.route.outputContract
            matchedPattern = $resolved.matchedPattern
            score = $resolved.score
        }

        if ($Json) {
            $result | ConvertTo-Json -Depth 5
        }
        else {
            $result | Format-List | Out-String
        }
        break
    }
    'show-route' {
        if (-not $RouteId) {
            throw "The show-route command requires -RouteId."
        }

        $route = Get-RouteById -RouteIdValue $RouteId -Manifest $manifest
        if ($Json) {
            $route | ConvertTo-Json -Depth 5
        }
        else {
            $route | Format-List | Out-String
        }
        break
    }
    'build' {
        $resolvedRoute = $null
        $matchedPattern = $null

        if ($RouteId) {
            $resolvedRoute = Get-RouteById -RouteIdValue $RouteId -Manifest $manifest
        }
        elseif ($Query) {
            $resolved = Resolve-RouteFromQuery -QueryValue $Query -Manifest $manifest
            $resolvedRoute = $resolved.route
            $matchedPattern = $resolved.matchedPattern
        }
        else {
            throw "The build command requires -RouteId or -Query."
        }

        $package = Build-PromptPackage -Route $resolvedRoute -MatchedPattern $matchedPattern
        Write-Result -Text $package
        break
    }
}

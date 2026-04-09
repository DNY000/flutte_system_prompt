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
    [ValidateSet('none', 'auto', 'decisions', 'patterns', 'mistakes', 'glossary', 'modules', 'all')]
    [string[]]$Memory = @('none'),
    [switch]$SkipProjectContext,
    [switch]$IncludeReferences,
    [switch]$PersistRun,
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
    $normalized = $normalized.Replace([char]0x0111, 'd')
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

function Assert-BuildInputClarity {
    param(
        [AllowEmptyString()]
        [string]$GoalValue,
        [AllowEmptyString()]
        [string]$QueryValue,
        [string[]]$RelatedItems,
        [string[]]$ExtraContextItems,
        [string[]]$ExpectedResultItems
    )

    $hasRequirement = -not [string]::IsNullOrWhiteSpace($GoalValue) -or -not [string]::IsNullOrWhiteSpace($QueryValue)
    $hasCode = @($RelatedItems | Where-Object { $_ }).Count -gt 0 -or @($ExtraContextItems | Where-Object { $_ }).Count -gt 0
    $hasExpectedResult = @($ExpectedResultItems | Where-Object { $_ }).Count -gt 0

    $clarifications = @()
    if (-not $hasRequirement) {
        $clarifications += '- What exactly should be solved?'
    }
    if (-not $hasCode) {
        $clarifications += '- Please share a real code snippet or related file path.'
    }
    if (-not $hasExpectedResult) {
        $clarifications += '- What is the expected result?'
    }

    if ($clarifications.Count -gt 0) {
        throw @"
Missing required input clarity fields for build.
Provide all of:
- clear requirement
- real code snippet or related code file
- expected result

Clarification:
$($clarifications -join "`n")
"@.Trim()
    }
}

function Test-AnyNormalizedSignal {
    param(
        [AllowEmptyString()]
        [string]$Text,
        [string[]]$Signals
    )

    $normalizedText = Normalize-Text -Text $Text
    if (-not $normalizedText) {
        return $false
    }

    foreach ($signal in @($Signals | Where-Object { $_ })) {
        $normalizedSignal = Normalize-Text -Text $signal
        if ($normalizedSignal -and $normalizedText.Contains($normalizedSignal)) {
            return $true
        }
    }

    return $false
}

function Add-UniqueItem {
    param(
        [System.Collections.Generic.List[string]]$List,
        [string]$Value
    )

    if (-not $Value) {
        return
    }

    if (-not $List.Contains($Value)) {
        $List.Add($Value)
    }
}

function Get-MemoryFilePath {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('decisions', 'patterns', 'mistakes', 'glossary', 'modules')]
        [string]$MemoryKey
    )

    switch ($MemoryKey) {
        'decisions' { return 'docs/ai/03-memory/decisions.md' }
        'patterns' { return 'docs/ai/03-memory/patterns.md' }
        'mistakes' { return 'docs/ai/03-memory/mistakes.md' }
        'glossary' { return 'docs/ai/03-memory/glossary.md' }
        'modules' { return 'docs/ai/03-memory/modules.md' }
    }
}

function Get-SuggestedMemoryFiles {
    param(
        [Parameter(Mandatory = $true)]
        $Route,
        [AllowEmptyString()]
        [string]$QueryValue
    )

    $files = New-Object System.Collections.Generic.List[string]

    if (@('architecture', 'ai-system', 'ci-cd', 'ba', 'flutter-decision') -contains $Route.taskType) {
        Add-UniqueItem -List $files -Value (Get-MemoryFilePath -MemoryKey 'decisions')
    }

    if (@('code', 'architecture', 'design', 'performance', 'test', 'ai-system') -contains $Route.taskType) {
        Add-UniqueItem -List $files -Value (Get-MemoryFilePath -MemoryKey 'patterns')
    }

    if (
        @('review', 'security', 'performance', 'test') -contains $Route.taskType -or
        $Route.routeId -eq 'debug-triage' -or
        (Test-AnyNormalizedSignal -Text $QueryValue -Signals @('bug', 'crash', 'regression', 'incident', 'mistake', 'triage'))
    ) {
        Add-UniqueItem -List $files -Value (Get-MemoryFilePath -MemoryKey 'mistakes')
    }

    if (@('flutter-decision', 'architecture', 'ai-system', 'ba') -contains $Route.taskType) {
        Add-UniqueItem -List $files -Value (Get-MemoryFilePath -MemoryKey 'glossary')
    }

    if (
        @('architecture', 'code', 'ai-system', 'ci-cd') -contains $Route.taskType -or
        (Test-AnyNormalizedSignal -Text $QueryValue -Signals @('architecture', 'module', 'modules', 'feature', 'folder structure', 'boundary', 'plugin', 'routing'))
    ) {
        Add-UniqueItem -List $files -Value (Get-MemoryFilePath -MemoryKey 'modules')
    }

    return @($files)
}

function Get-MemoryFiles {
    param(
        [string[]]$Selection,
        $Route,
        [AllowEmptyString()]
        [string]$QueryValue
    )

    if ($Selection -contains 'none') {
        return @()
    }

    if ($Selection -contains 'all') {
        return @(
            (Get-MemoryFilePath -MemoryKey 'decisions'),
            (Get-MemoryFilePath -MemoryKey 'patterns'),
            (Get-MemoryFilePath -MemoryKey 'mistakes'),
            (Get-MemoryFilePath -MemoryKey 'glossary'),
            (Get-MemoryFilePath -MemoryKey 'modules')
        )
    }

    if ($Selection -contains 'auto') {
        if ($null -eq $Route) {
            return @()
        }
        return Get-SuggestedMemoryFiles -Route $Route -QueryValue $QueryValue
    }

    $files = @()
    foreach ($item in $Selection) {
        switch ($item) {
            'decisions' { $files += (Get-MemoryFilePath -MemoryKey 'decisions') }
            'patterns' { $files += (Get-MemoryFilePath -MemoryKey 'patterns') }
            'mistakes' { $files += (Get-MemoryFilePath -MemoryKey 'mistakes') }
            'glossary' { $files += (Get-MemoryFilePath -MemoryKey 'glossary') }
            'modules' { $files += (Get-MemoryFilePath -MemoryKey 'modules') }
        }
    }

    return @($files | Select-Object -Unique)
}

function Get-ExecutionPolicy {
    param(
        [Parameter(Mandatory = $true)]
        $Route,
        [AllowEmptyString()]
        [string]$QueryValue,
        [string[]]$SelectedMemoryFiles = @()
    )

    $routeSkills = @($Route.skills)
    $specialistSkills = @($routeSkills | Where-Object { $_ -notin @('intent-router', 'context-loader', 'quality-grader', 'source-validator') })
    $suggestedMemoryFiles = @(Get-SuggestedMemoryFiles -Route $Route -QueryValue $QueryValue)

    $researchNeeded = 'false'
    if ($Route.taskType -eq 'research' -or $routeSkills -contains 'source-validator') {
        $researchNeeded = 'true'
    }
    elseif (Test-AnyNormalizedSignal -Text $QueryValue -Signals @('latest', 'current', 'today', 'version', 'release note', 'release notes', 'changelog', 'official docs', 'official doc', 'documentation', 'compare package', 'best package', 'benchmark')) {
        $researchNeeded = if ($Route.riskLevel -eq 'high') { 'true' } else { 'optional' }
    }
    elseif ($Route.routeId -in @('package-selection', 'plugin-authoring', 'pipeline-change', 'security-audit', 'security-implement', 'prompt-system-roadmap', 'agent-system-roadmap', 'eval-system-roadmap')) {
        $researchNeeded = 'optional'
    }

    $mcpNeeded = 'false'
    if (Test-AnyNormalizedSignal -Text $QueryValue -Signals @('mcp', 'connector', 'schema', 'figma', 'ticket', 'tickets', 'issue tracker', 'internal docs', 'workspace data', 'repo data', 'repository data')) {
        $mcpNeeded = if ($routeSkills -contains 'mcp-orchestrator') { 'true' } else { 'optional' }
    }
    elseif ($routeSkills -contains 'mcp-orchestrator') {
        $mcpNeeded = 'optional'
    }

    $multiAgentMode = 'off'
    if ($Route.routeId -eq 'agent-system-roadmap') {
        $multiAgentMode = 'recommended'
    }
    elseif ($specialistSkills.Count -ge 4) {
        $multiAgentMode = 'consider'
    }
    elseif ($Route.riskLevel -eq 'high' -and @('architecture', 'security', 'performance', 'test', 'ai-system') -contains $Route.taskType -and $specialistSkills.Count -ge 3) {
        $multiAgentMode = 'consider'
    }

    $memoryWrite = 'optional'
    if (@($SelectedMemoryFiles | Where-Object { $_ }).Count -gt 0) {
        $memoryWrite = 'enabled'
    }
    elseif (
        @('architecture', 'ai-system', 'ba', 'ci-cd') -contains $Route.taskType -or
        $Route.routeId -in @('state-management-decision', 'package-selection', 'code-organization-decision', 'module-design-decision', 'pattern-selection', 'plugin-authoring', 'offline-sync-strategy', 'web-desktop-strategy', 'add-to-app')
    ) {
        $memoryWrite = 'likely'
    }

    return [pscustomobject]@{
        researchNeeded = $researchNeeded
        mcpNeeded = $mcpNeeded
        multiAgentMode = $multiAgentMode
        memoryWrite = $memoryWrite
        suggestedMemoryFiles = $suggestedMemoryFiles
    }
}

function New-RunRequestId {
    return ('{0}-{1}' -f (Get-Date -Format 'yyyyMMddHHmmssfff'), ([guid]::NewGuid().ToString('N').Substring(0, 8)))
}

function Get-TextHash {
    param([AllowEmptyString()][string]$Text)

    $bytes = [Text.Encoding]::UTF8.GetBytes($(if ($null -eq $Text) { '' } else { $Text }))
    $sha = [Security.Cryptography.SHA256]::Create()
    try {
        $hash = $sha.ComputeHash($bytes)
        return ([BitConverter]::ToString($hash)).Replace('-', '').ToLowerInvariant()
    }
    finally {
        $sha.Dispose()
    }
}

function Write-RunRecord {
    param(
        [Parameter(Mandatory = $true)]
        $Record
    )

    $runsDir = Join-Path $script:RepoRoot '.promptos\runs'
    New-Item -ItemType Directory -Force -Path $runsDir | Out-Null

    $timestamp = Get-Date
    $fileName = '{0}-{1}-{2}.json' -f $timestamp.ToString('yyyyMMdd-HHmmssfff'), $Record.command, $Record.routeId
    $targetPath = Join-Path $runsDir $fileName
    $Record | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $targetPath -Encoding UTF8
    return $targetPath
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
        [bool]$NeedReferences,
        [Parameter(Mandatory = $true)]
        $ExecutionPolicy
    )

    $secondaryIntent = 'none'
    $memoryItems = @($MemoryFiles | Where-Object { $_ })
    $extraItems = @($ExtraFiles | Where-Object { $_ })
    $sectionItems = @($SectionIds | Where-Object { $_ })
    $domainItems = @($DomainIds | Where-Object { $_ })
    $requiredContextItems = @($RequiredContext | Where-Object { $_ })
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
- mcp_needed: $($ExecutionPolicy.mcpNeeded)
- research_needed: $($ExecutionPolicy.researchNeeded)
- multi_agent_mode: $($ExecutionPolicy.multiAgentMode)
- memory_write: $($ExecutionPolicy.memoryWrite)

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

    if ($Route.PSObject.Properties.Name -contains 'contextFiles') {
        $routeContextFiles += @($Route.contextFiles | Where-Object { $_ })
    }

    if (Test-GuidePackSupport -Route $Route) {
        $domainManifest = Get-DomainManifest
        $resolvedDomains = Resolve-FlutterDomains -QueryValue $Query -Route $Route -DomainManifest $domainManifest
        $routeContextFiles += 'docs/ai/00-core/decision-engine.md'
        $routeContextFiles += 'docs/ai/00-core/self-analysis-protocol.md'
        $routeContextFiles += 'docs/ai/08-guides/flutter/index.md'
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

    $memoryFiles = Get-MemoryFiles -Selection $Memory -Route $Route -QueryValue $Query
    $executionPolicy = Get-ExecutionPolicy -Route $Route -QueryValue $Query -SelectedMemoryFiles @($memoryFiles)
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

    $routeResolution = Get-RouteResolutionBlock -Route $Route -MatchedPattern $MatchedPattern -RequiredContext $requiredContext -ExtraFiles @($ExtraContextFiles) -MemoryFiles @($memoryFiles) -SectionIds @($resolvedDomains.sectionIds) -DomainIds @($resolvedDomains.domainIds) -NeedReferences $IncludeReferences.IsPresent -ExecutionPolicy $executionPolicy

    $taskStatement = if (-not [string]::IsNullOrWhiteSpace($Goal)) {
        $Goal
    }
    elseif (-not [string]::IsNullOrWhiteSpace($Query)) {
        $Query
    }
    else {
        "Giải quyết vấn đề route $($Route.routeId)"
    }

    $contextRequirement = @(
        @($Goal | Where-Object { $_ })
        @($Scope | Where-Object { $_ })
        @($Query | Where-Object { $_ } | ForEach-Object { "Original query: $_" })
    ) | Select-Object -Unique
    $contextCode = @(
        @($Related | Where-Object { $_ })
        @($ExtraContextFiles | Where-Object { $_ })
    ) | Select-Object -Unique

    $requestBody = @"
Role: Bạn là senior Flutter developer
Task: $taskStatement
Context:
- Requirement
$(Format-BulletList -Items $contextRequirement)
- Code/Input
$(Format-BulletList -Items $contextCode)
- Expected result
$(Format-BulletList -Items $DefinitionOfDone)
Constraints:
- Ngắn gọn
- Không lan man
- Đúng trọng tâm
$(if (@($Constraints | Where-Object { $_ }).Count -gt 0) { (Format-BulletList -Items @($Constraints | Where-Object { $_ } | ForEach-Object { "Bổ sung: $_" })) } else { '' })
Output:
- Root cause
- Fix code
- Notes (optional)
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

    $text = @"
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

    return [pscustomobject]@{
        text = $text
        requiredContext = @($requiredContext | Select-Object -Unique)
        routeContextFiles = @($routeContextFiles | Select-Object -Unique)
        memoryFiles = @($memoryFiles | Select-Object -Unique)
        executionPolicy = $executionPolicy
        resolvedDomains = $resolvedDomains
    }
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
  .\aiprompt.ps1 resolve -Query "design login screen UI"
  .\aiprompt.ps1 show-route -RouteId design-screen
  .\aiprompt.ps1 build -RouteId design-screen -Goal "Design login screen" -Related "lib\features\auth\presentation\login_screen.dart" -DefinitionOfDone "Return root cause + fix code + short notes"
  .\aiprompt.ps1 build -Query "design login screen UI" -Goal "Design login screen" -Related "lib\features\auth\presentation\login_screen.dart" -DefinitionOfDone "Return root cause + fix code + short notes" -OutputPath .out\login-prompt.md

Common options:
  -Related lib/features/auth/presentation/login_screen.dart
  -Constraints "Use Material 3" "Support tablet"
  -DefinitionOfDone "Include empty and error states"
  -ExtraContextFiles docs/ai/06-examples/route-examples.md
  -Memory auto
  -Memory decisions patterns glossary
  -PersistRun
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
        $selectedMemoryFiles = Get-MemoryFiles -Selection $Memory -Route $resolved.route -QueryValue $Query
        $executionPolicy = Get-ExecutionPolicy -Route $resolved.route -QueryValue $Query -SelectedMemoryFiles @($selectedMemoryFiles)
        $result = [pscustomobject]@{
            routeId = $resolved.route.routeId
            taskType = $resolved.route.taskType
            primaryIntent = $resolved.route.primaryIntent
            outputContract = $resolved.route.outputContract
            matchedPattern = $resolved.matchedPattern
            score = $resolved.score
            executionPolicy = $executionPolicy
        }

        if ($PersistRun) {
            $runRecord = [pscustomobject]@{
                requestId = New-RunRequestId
                timestamp = (Get-Date).ToString('o')
                runtime = 'prompt-cli-powershell'
                command = 'resolve'
                routeId = $resolved.route.routeId
                outputContract = $resolved.route.outputContract
                riskLevel = $resolved.route.riskLevel
                matchedPattern = $resolved.matchedPattern
                queryLength = $(if ($null -eq $Query) { 0 } else { $Query.Length })
                queryHash = Get-TextHash -Text $Query
                executionPolicy = $executionPolicy
            }
            [void](Write-RunRecord -Record $runRecord)
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

        Assert-BuildInputClarity -GoalValue $Goal -QueryValue $Query -RelatedItems @($Related) -ExtraContextItems @($ExtraContextFiles) -ExpectedResultItems @($DefinitionOfDone)

        $package = Build-PromptPackage -Route $resolvedRoute -MatchedPattern $matchedPattern

        if ($PersistRun) {
            $runRecord = [pscustomobject]@{
                requestId = New-RunRequestId
                timestamp = (Get-Date).ToString('o')
                runtime = 'prompt-cli-powershell'
                command = 'build'
                routeId = $resolvedRoute.routeId
                outputContract = $resolvedRoute.outputContract
                riskLevel = $resolvedRoute.riskLevel
                matchedPattern = $(if ($matchedPattern) { $matchedPattern } else { 'manual-route' })
                queryLength = $(if ($null -eq $Query) { 0 } else { $Query.Length })
                queryHash = Get-TextHash -Text $Query
                requiredContext = $package.requiredContext
                routeContextFiles = $package.routeContextFiles
                memoryFiles = $package.memoryFiles
                executionPolicy = $package.executionPolicy
                outputPath = $(if ($OutputPath) { $OutputPath } else { $null })
            }
            [void](Write-RunRecord -Record $runRecord)
        }

        Write-Result -Text $package.text
        break
    }
}

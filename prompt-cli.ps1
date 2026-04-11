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
    [switch]$ForceProjectContext,
    [switch]$IncludeReferences,
    [switch]$PersistRun,
    [string]$OutputPath,
    [switch]$Clipboard,
    [ValidateSet('auto', 'manual', 'openai', 'google')]
    [string]$ProviderAdapter = 'auto',
    [switch]$Json
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $PSScriptRoot 'tools\prompt-powershell\prompt-cli.ps1'
if (-not (Test-Path -LiteralPath $scriptPath)) {
    throw "Missing prompt CLI entry point: $scriptPath"
}

& $scriptPath `
    -Command $Command `
    -RouteId $RouteId `
    -Query $Query `
    -Goal $Goal `
    -Scope $Scope `
    -Related $Related `
    -Constraints $Constraints `
    -DefinitionOfDone $DefinitionOfDone `
    -ExtraContextFiles $ExtraContextFiles `
    -Memory $Memory `
    -SkipProjectContext:$SkipProjectContext `
    -ForceProjectContext:$ForceProjectContext `
    -IncludeReferences:$IncludeReferences `
    -PersistRun:$PersistRun `
    -OutputPath $OutputPath `
    -Clipboard:$Clipboard `
    -ProviderAdapter $ProviderAdapter `
    -Json:$Json

if (Get-Variable -Name LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue) {
    exit $LASTEXITCODE
}

exit 0

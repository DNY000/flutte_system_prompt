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

$scriptPath = Join-Path $PSScriptRoot 'tools\prompt-cli\aiprompt.ps1'
$forward = @{
    Command = $Command
    Memory = $Memory
}

if ($PSBoundParameters.ContainsKey('RouteId')) { $forward.RouteId = $RouteId }
if ($PSBoundParameters.ContainsKey('Query')) { $forward.Query = $Query }
if ($PSBoundParameters.ContainsKey('Goal')) { $forward.Goal = $Goal }
if ($PSBoundParameters.ContainsKey('Scope')) { $forward.Scope = $Scope }
if ($PSBoundParameters.ContainsKey('Related')) { $forward.Related = $Related }
if ($PSBoundParameters.ContainsKey('Constraints')) { $forward.Constraints = $Constraints }
if ($PSBoundParameters.ContainsKey('DefinitionOfDone')) { $forward.DefinitionOfDone = $DefinitionOfDone }
if ($PSBoundParameters.ContainsKey('ExtraContextFiles')) { $forward.ExtraContextFiles = $ExtraContextFiles }
if ($SkipProjectContext) { $forward.SkipProjectContext = $true }
if ($IncludeReferences) { $forward.IncludeReferences = $true }
if ($PSBoundParameters.ContainsKey('OutputPath')) { $forward.OutputPath = $OutputPath }
if ($Clipboard) { $forward.Clipboard = $true }
if ($Json) { $forward.Json = $true }

& $scriptPath @forward
exit $LASTEXITCODE

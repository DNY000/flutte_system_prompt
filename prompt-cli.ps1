Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $PSScriptRoot 'tools\prompt-powershell\prompt-cli.ps1'
if (-not (Test-Path -LiteralPath $scriptPath)) {
    throw "Missing prompt CLI entry point: $scriptPath"
}

& $scriptPath @args
if (Get-Variable -Name LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue) {
    exit $LASTEXITCODE
}

exit 0

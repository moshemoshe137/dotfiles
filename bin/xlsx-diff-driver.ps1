#!/usr/bin/env pwsh

# The path to the .xlsx file
param(
    [String]$XlsxFile
)

# Convert Windows paths to Unix format if necessary and escape backslashes for PowerShell
$XlsxFile = $XlsxFile -replace '\\', '/'

# Create a temporary directory for unzipping
$TempDir = New-Item -ItemType Directory -Force -Path ([System.IO.Path]::GetTempPath() + [System.IO.Path]::GetRandomFileName())

# Ensure temporary directory is removed on script exit
trap {
    Remove-Item -Recurse -Force $TempDir
    exit
}

# Unzip the .xlsx file into the temporary directory
Expand-Archive -Path $XlsxFile -DestinationPath $TempDir -Force

# Recursively find all files in the unzipped directory
Get-ChildItem -Path $TempDir -Recurse | Where-Object { -not $_.PSIsContainer } | ForEach-Object {
    if ($_.Extension -eq '.xml') {
        # Load and format XML content, then output, using -LiteralPath for literal path handling
        $XmlContent = [xml](Get-Content -LiteralPath $_.FullName)
        $XmlContent.Save([Console]::Out)
    } else {
        # For non-XML files, output the content directly, using -LiteralPath for literal path handling
        Get-Content -LiteralPath $_.FullName | Out-Host
    }
}

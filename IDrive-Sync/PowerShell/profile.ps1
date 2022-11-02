# The VPN at work likes to fuck up my home drive, so let's point explicitly to .gitconfig
$env:GIT_CONFIG_GLOBAL = "C:\Users\mrubin8\.gitconfig"

# Pip environment variables:
## Save me from myself:
$env:PIP_REQUIRE_VIRTUALENV=$true
## Using py launcher, I could not care less about this path crap
$env:PIP_NO_WARN_SCRIPT_LOCATION=$false  # gh: pypa/pip#6372

# Aliases
New-Alias e explorer.exe
New-Alias g git
function path{
    $env:path -split ";"
}

# https://devblogs.microsoft.com/scripting/increase-powershell-command-history-to-the-max-almost/
$MaximumHistoryCount=32767
# Enable predictive tab-completion
Set-PSReadLineOption -PredictionSource History

# Import the posh-git module and set up my settings
Import-Module posh-git;
## Not useful right now
$GitPromptSettings.EnableFileStatus = $false;
## Abbreviate 'C:\Users\mrubin8\' as '~'
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true;
## Abbreviate 'C:\Users\mrubin8\example.git' as 'example: '
$GitPromptSettings.DefaultPromptAbbreviateGitDirectory = $true;

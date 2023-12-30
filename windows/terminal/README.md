https://github.com/PowerShell/PSReadLine

PSReadLine is included in latest version of powershell.

Install latest version of powershell:
```powershell
winget install --id Microsoft.Powershell --source winget
```

Allow powershell profile on terminal start:
```powershell
Set-ExecutionPolicy remotesigned
```

Open powershell profile using `$PROFILE` and put this in the profile file:
```powershell
Set-PSReadLineOption -ShowToolTips

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key Ctrl+Tab  -Function TabCompleteNext

# Autocompletion for Arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Recognizes python, ruby and powershell scripts
$env:PATHEXT += ";.py"
$env:PATHEXT += ";.rb"
$env:PATHEXT += ";.ps1"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
```
## Install
Run in powershell:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
## Automatic package installation prompt confirmation:
Run in terminal:
```
choco feature enable -n=allowGlobalConfirmation
```

## Automatic package update
Create a task scheduler job which runs [this](\scripts\choco-upgrade-all.bat) script every week.

```powershell
$scriptPath = "PATH\TO\SCRIPT"
$taskTrigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday -At 4pm
$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File $path -Output 'HTML'" -WorkingDirectory "c:\scripts"

Register-ScheduledTask "Lazy PS Tasks" -Action $taskAction -Trigger $taskTrigger
```

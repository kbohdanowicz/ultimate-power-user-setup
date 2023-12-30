## Install
Run in cmd:
```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

## Install all apps script
```
choco install Chocolatey 7zip.portable adobereader autohotkey.portable borderlessgaming chocolatey chocolatey-compatibility.extension chocolatey-core.extension chocolatey-os-dependency.extension compactgui cpu-z.install crystaldiskinfo crystaldiskinfo.portable dotnet-6.0-desktopruntime dotnet-7.0-desktopruntime dotnet-desktopruntime dotnetfx easy.install Everything f.lux f.lux.install ferdium ffmpeg git git.install gradle gsudo handbrake.install itch KB2919355 KB2919442 KB2999226 KB3033929 KB3035131 KB3063858 messenger msys2 obsidian openhardwaremonitor powertoys python python3 rust rustup.install screentogif screentogif.portable sharex signal SQLite vcredist140 vcredist2010 vcredist2015 winaero-tweaker winaero-tweaker.install yarn youtube-dl-gui.install
```

## Automatic package update
Create a task scheduler job which runs this `.bat` script every week:
```bat
@echo off

choco upgrade all
```

## Apps
- `7zip.portable`
- `adobereader`
- `autohotkey.portable`
- `chocolatey`
- `chocolatey-compatibility.extension`
- `chocolatey-core.extension`
- `chocolatey-os-dependency.extension`
- `compactgui`
- `cpu-z.install`
- `crystaldiskinfo`
- `crystaldiskinfo.portable`
- `dotnet-6.0-desktopruntime`
- `dotnet-7.0-desktopruntime`
- `dotnet-desktopruntime`
- `dotnetfx`
- `easy.install`
- `Everything`
- `f.lux`
- `f.lux.install`
- `ffmpeg`
- `git`
- `git.install`
- `GoogleChrome`
- `gradle`
- `gsudo`
- `handbrake.install`
- `itch`
- `KB2919355`
- `KB2919442`
- `KB2999226`
- `KB3033929`
- `KB3035131`
- `KB3063858`
- `messenger`
- `msys2`
- `obsidian`
- `openhardwaremonitor`
- `powertoys`
- `python`
- `python3`
- `rust`
- `rustup.install`
- `screentogif`
- `screentogif.portable`
- `signal`
- `SQLite`
- `vcredist140`
- `vcredist2010`
- `vcredist2015`
- `winaero-tweaker`
- `winaero-tweaker.install`
- `yarn`
- `youtube-dl-gui.install`

## Get install script for all installed packages
_nu shell_
```
choco list all | lines | each {|it| $it | split row " " | first } | drop 1 | prepend "choco install" | into string | str join " "
```

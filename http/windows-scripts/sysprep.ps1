$ErrorActionPreference = "Stop"

# Not under SystemRoot\Temp, which the cleanup below wipes
New-Item -ItemType Directory -Path "$env:SystemRoot\Setup\Scripts" -Force | Out-Null
Start-Transcript -Path "$env:SystemRoot\Setup\Scripts\sysprep.log" -Append | Out-Null

try {

# --- Cleanup before sealing the template ---

# Windows Update download cache
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:SystemRoot\SoftwareDistribution\Download\*" -ErrorAction SilentlyContinue

# Temp directories
Remove-Item -Recurse -Force "$env:SystemRoot\Temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:TEMP\*" -ErrorAction SilentlyContinue

# Clones have no script CD, so they need setup.ps1 on disk to re-enable WinRM
Copy-Item -Path "$PSScriptRoot\setup.ps1" -Destination "$env:SystemRoot\Setup\Scripts\setup.ps1" -Force

# Staged, not passed to sysprep.exe: windows reads it from Panther on the clone's first boot
$unattend = Get-PSDrive -PSProvider FileSystem |
    ForEach-Object { Join-Path $_.Root "sysprep-unattend.xml" } |
    Where-Object { Test-Path $_ } |
    Select-Object -First 1
if (-not $unattend) { throw "sysprep-unattend.xml not found on any attached drive" }
Copy-Item -Path $unattend -Destination "$env:SystemRoot\Panther\unattend.xml" -Force

# Some analytic/debug channels deny access even to SYSTEM
$ErrorActionPreference = "SilentlyContinue"
wevtutil el | ForEach-Object { wevtutil cl $_ 2>$null }
$ErrorActionPreference = "Stop"

# --- Generalize ---
Write-Output "starting sysprep, the VM powers off when it finishes"

# Stop before sysprep, or the shutdown truncates the log mid-write
Stop-Transcript | Out-Null

# /shutdown, not /quit: generalize removes the NIC, nothing can report back after
Start-Process -FilePath "$env:SystemRoot\System32\Sysprep\sysprep.exe" `
    -ArgumentList "/generalize", "/oobe", "/quiet", "/shutdown"

} catch {
    Stop-Transcript | Out-Null
    throw
}

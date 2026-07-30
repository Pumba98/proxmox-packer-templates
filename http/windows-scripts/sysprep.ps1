$ErrorActionPreference = "Stop"

# --- Cleanup before sealing the template ---

# Windows Update download cache
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:SystemRoot\SoftwareDistribution\Download\*" -ErrorAction SilentlyContinue

# Temp directories
Remove-Item -Recurse -Force "$env:SystemRoot\Temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:TEMP\*" -ErrorAction SilentlyContinue

# Clones have no script CD, so they need setup.ps1 on disk to re-enable WinRM
New-Item -ItemType Directory -Path "$env:SystemRoot\Setup\Scripts" -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\setup.ps1" -Destination "$env:SystemRoot\Setup\Scripts\setup.ps1" -Force

# On its own CD, so scan the drives. Windows reads it from Panther on the clone's first boot
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
$proc = Start-Process -FilePath "$env:SystemRoot\System32\Sysprep\sysprep.exe" `
    -ArgumentList "/generalize", "/oobe", "/mode:vm", "/quiet", "/quit" `
    -Wait -NoNewWindow -PassThru
if ($proc.ExitCode -ne 0) { throw "sysprep exited with $($proc.ExitCode)" }

$deadline = (Get-Date).AddMinutes(30)
while ((Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State").ImageState `
        -ne "IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE") {
    if ((Get-Date) -ge $deadline) { throw "sysprep did not seal the image within 30 minutes" }
    Start-Sleep -Seconds 5
}

Write-Output "image sealed"

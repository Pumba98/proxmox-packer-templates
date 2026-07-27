$ErrorActionPreference = "Stop"

# --- Cleanup before sealing the template ---

# Windows Update download cache
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:SystemRoot\SoftwareDistribution\Download\*" -ErrorAction SilentlyContinue

# Temp directories
Remove-Item -Recurse -Force "$env:SystemRoot\Temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:TEMP\*" -ErrorAction SilentlyContinue

# Persist the first-boot setup script so clones can re-enable WinRM after sysprep
# (the script CDs are not attached to cloned VMs)
New-Item -ItemType Directory -Path "$env:SystemRoot\Setup\Scripts" -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\setup.ps1" -Destination "$env:SystemRoot\Setup\Scripts\setup.ps1" -Force

# Find the templated sysprep unattend file on the unattended CD
$unattend = Get-PSDrive -PSProvider FileSystem |
    ForEach-Object { Join-Path $_.Root "sysprep-unattend.xml" } |
    Where-Object { Test-Path $_ } |
    Select-Object -First 1
if (-not $unattend) { throw "sysprep-unattend.xml not found on any attached drive" }
Copy-Item -Path $unattend -Destination "$env:SystemRoot\Panther\unattend.xml" -Force

# Clear event logs (last, so the cleanup noise is gone too)
$ErrorActionPreference = "SilentlyContinue"
wevtutil el | ForEach-Object { wevtutil cl $_ }
$ErrorActionPreference = "Stop"

# --- Generalize ---
# /quit instead of /shutdown: packer performs the shutdown itself after the provisioner.
# /mode:vm is safe here because clones run on the same virtual hardware.
Start-Process -FilePath "$env:SystemRoot\System32\Sysprep\sysprep.exe" `
    -ArgumentList "/generalize", "/oobe", "/mode:vm", "/quiet", "/quit", "/unattend:$env:SystemRoot\Panther\unattend.xml" `
    -Wait -NoNewWindow

# Poll until windows reports the image is sealed
$deadline = (Get-Date).AddMinutes(30)
while ($true) {
    $imageState = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State").ImageState
    if ($imageState -eq "IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE") { break }

    if ((Get-Date) -ge $deadline) {
        Get-Content "$env:SystemRoot\System32\Sysprep\Panther\setuperr.log" -ErrorAction SilentlyContinue
        throw "Sysprep did not seal the image within 30 minutes, ImageState=$imageState"
    }

    Write-Output "waiting for sysprep, ImageState=$imageState"
    Start-Sleep -Seconds 10
}

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

# The file only defines the specialize/oobeSystem passes, which run on the clone's
# first boot. Windows picks it up from Panther automatically then, so it is staged
# here rather than passed to sysprep.exe below.
$cd = Get-Volume -FileSystemLabel "Windows Unattended CD" -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $cd) { throw "Windows Unattended CD not found" }
$unattend = "$($cd.DriveLetter):\sysprep-unattend.xml"
if (-not (Test-Path $unattend)) { throw "sysprep-unattend.xml not found on $unattend" }
Copy-Item -Path $unattend -Destination "$env:SystemRoot\Panther\unattend.xml" -Force

# Clear event logs (last, so the cleanup noise is gone too).
# A few analytic/debug channels deny access even to SYSTEM; skip their noise.
$ErrorActionPreference = "SilentlyContinue"
wevtutil el | ForEach-Object { wevtutil cl $_ 2>$null }
$ErrorActionPreference = "Stop"

# --- Generalize ---
# /quit instead of /shutdown: packer performs the shutdown itself after the provisioner.
#
# No /unattend: passing it makes sysprep run a generalize pass over the answer file,
# and on server 2019 that pass fails with 0x80070005 (E_ACCESSDENIED) even though the
# file defines no generalize settings. The staged copy in Panther is picked up on the
# clone's first boot regardless, which is all it is there for.
$start = Get-Date
$proc = Start-Process -FilePath "$env:SystemRoot\System32\Sysprep\sysprep.exe" `
    -ArgumentList "/generalize", "/oobe", "/quiet", "/quit" `
    -Wait -NoNewWindow -PassThru
Write-Output "sysprep.exe exited with $($proc.ExitCode)"

function Stop-WithSysprepLogs($message) {
    foreach ($log in "setuperr.log", "setupact.log") {
        $path = "$env:SystemRoot\System32\Sysprep\Panther\$log"
        if (Test-Path $path) {
            Write-Output "--- $log ---"
            Get-Content $path -Tail 60 -ErrorAction SilentlyContinue
        }
    }
    throw $message
}

# /quiet makes sysprep silent, so the exit code is the only sign it refused to run.
if ($proc.ExitCode -ne 0) {
    Stop-WithSysprepLogs "Sysprep exited with code $($proc.ExitCode)"
}

# sysprep.exe returns before generalization is done, so wait for the sealed state.
# Returning early would let packer power the VM off mid-generalize, and every clone
# would share the template's machine SID.
$deadline = (Get-Date).AddMinutes(10)
while ($true) {
    $imageState = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State").ImageState
    if ($imageState -eq "IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE") { break }

    if ($imageState -eq "IMAGE_STATE_COMPLETE" -and (Get-Date) -gt $start.AddSeconds(60)) {
        Stop-WithSysprepLogs "Sysprep exited 0 but left ImageState=IMAGE_STATE_COMPLETE, so it never generalized"
    }

    if ((Get-Date) -ge $deadline) {
        Stop-WithSysprepLogs "Sysprep did not seal the image within 10 minutes, ImageState=$imageState"
    }

    Write-Output "waiting for sysprep, ImageState=$imageState"
    Start-Sleep -Seconds 10
}

$ErrorActionPreference = "Stop"

# Enable WinRM without changing the network category. Changing it during the
# first interactive logon can display the Windows network-discovery prompt and
# block an unattended Packer build.
Enable-PSRemoting -SkipNetworkProfileCheck -Force
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Disable IPv6 because it leads to problems with proxmox terraform
Get-NetAdapter | foreach { Disable-NetAdapterBinding -InterfaceAlias $_.Name -ComponentID ms_tcpip6 }

# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0

# Run a custom installer script if there is one
$customInstaller = Join-Path $PSScriptRoot "custom\custom.ps1"
if (Test-Path $customInstaller) {
    & $customInstaller
}

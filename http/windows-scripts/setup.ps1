$ErrorActionPreference = "Stop"

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

Enable-PSRemoting -SkipNetworkProfileCheck -Force

Set-NetFirewallRule -Name 'WINRM-HTTP-In-TCP-PUBLIC' -RemoteAddress Any -ErrorAction SilentlyContinue

winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

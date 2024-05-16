<#
.SYNOPSIS
    Evaluate and install the Drata Agent on Windows systems.
    OS Support: Windows 7 and above

.DESCRIPTION
    This script checks if the Drata Agent is installed on the target Windows system,
    and if it's not installed, it proceeds to install and register the Drata Agent.
    The script supports both 32-bit and 64-bit Windows systems.

    Usage: You need to provide the following variables:

    $32bitInstallerPath: The path to the 32-bit installer file (e.g., "C:\Temp\DrataAgent_x86.msi").
    $64bitInstallerPath: The path to the 64-bit installer file (e.g., "C:\Temp\DrataAgent_x64.msi").
    $SiteToken: The site token provided by Drata for registering the agent.

.EXAMPLE
    $32bitInstallerPath = "C:\Temp\DrataAgent_x86.msi"
    $64bitInstallerPath = "C:\Temp\DrataAgent_x64.msi"
    $SiteToken = "ABCD123"

.NOTES
    Author: Your Name
    Date: [Current Date]
#>

param (
    [string]$32bitInstallerPath,
    [string]$64bitInstallerPath,
    [string]$SiteToken
)

# Check if the Drata Agent is already installed
$installedVersions = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName -like "*Drata Agent*" }
if ($installedVersions) {
    Write-Output "Drata Agent is already installed."
    return
}

# Define the installer path based on the system architecture
if ([System.Environment]::Is64BitOperatingSystem) {
    $installerPath = $64bitInstallerPath
}
else {
    $installerPath = $32bitInstallerPath
}

# Install the Drata Agent
$arguments = "/quiet /norestart SITE_TOKEN=$SiteToken"
$process = Start-Process -FilePath $installerPath -ArgumentList $arguments -Wait -PassThru

# Check the installation exit code
if ($process.ExitCode -eq 0) {
    Write-Output "Drata Agent installed successfully."
}
elseif ($process.ExitCode -eq 1618) {
    Write-Output "Installation failed. The endpoint must be restarted before reinstalling the Drata Agent."
}
else {
    Write-Output "Installation failed with exit code: $($process.ExitCode)"
}
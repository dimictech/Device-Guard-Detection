$credentialGuardStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "LsaCfgFlags" -ErrorAction SilentlyContinue

if ($credentialGuardStatus.LsaCfgFlags -eq 1) {
    Write-Output "Credential Guard is enabled. Disabling it now..."

    Disable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard -NoRestart
    reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f
    reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d "0" /f
    reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d "0" /f

    $hyperVStatus = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

    if ($hyperVStatus.State -eq "Enabled") {
        Write-Output "Hyper-V is enabled. Disabling it now..."
        Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
    } else {
        Write-Output "Hyper-V is already disabled."
    }

    Write-Output "Registry changes completed."
} else {
    Write-Output "Credential Guard is already disabled. No action needed."
}

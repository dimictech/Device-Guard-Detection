$credentialGuardStatus = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "LsaCfgFlags" -ErrorAction SilentlyContinue

if ($credentialGuardStatus.LsaCfgFlags -ne 1) {
    Write-Output "Credential Guard is disabled. Enabling it now"

    Enable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard -NoRestart
    reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "1" /f
    reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d "1" /f
    reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d "1" /f

    $hyperVStatus = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

    if ($hyperVStatus.State -ne "Enabled") {
        Write-Output "Hyper-V is disabled. Enabling it now"
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
    } else {
        Write-Output "Hyper-V is already enabled"
    }

    Write-Output "Registry changes completed"
} else {
    Write-Output "Credential Guard is already enabled. No action needed"
}

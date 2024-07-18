## To disable or enable Device Guard, follow these instructions:

### Disable Device Guard

Run PowerShell with administrator rights and paste the following command:

```powershell
irm https://raw.githubusercontent.com/petardimicc/DisableDeviceGuard/main/DisableDeviceGuard.ps1 | iex
```

### Enable Device Guard

Run PowerShell with administrator rights and paste the following command:

```powershell
irm https://raw.githubusercontent.com/petardimicc/DisableDeviceGuard/main/EnableDeviceGuard.ps1 | iex
```

**Note:** Auto restarting is disabled. Please manually restart your computer after running these commands.

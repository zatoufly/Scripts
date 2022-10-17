$MACHINE_NAME = Read-Host "Set PC Name"
$MACHINE_DESC_NAME = Read-Host "Set PC Desc"

# Désactiver l'UAC
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

# Renommer la machine
Rename-Computer -NewName $MACHINE_NAME

# Set une desc au PC
$MACHINE_DESC_NAME2 = @{Description = $MACHINE_DESC_NAME}
Set-CimInstance -Query 'Select * From Win32_OperatingSystem' -Property $MACHINE_DESC_NAME2

# Install Windows Feature : Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -Online -NoRestart -ErrorAction Stop
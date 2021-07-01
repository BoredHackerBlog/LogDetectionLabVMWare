echo Stopping updates
sc config wuauserv start= disabled
net stop wuauserv

echo Disabling firewall
netsh advfirewall set allprofiles state off

echo Disabling Defender
powershell Set-MpPreference -DisableRealtimeMonitoring:$true
powershell 'New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -PropertyType DWord -Value 1'
powershell 'Add-MpPreference -ExclusionPath "C:\AtomicRedTeam"'

echo Disabling UAC
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

echo Enabling RDP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
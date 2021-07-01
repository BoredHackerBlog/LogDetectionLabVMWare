echo creating C:\loggingsetup and moving to it
mkdir C:\loggingsetup
cd C:\loggingsetup

echo Enabling process and command line auditing
auditpol /Set /subcategory:"Process Creation" /Success:Enable
auditpol /Set /subcategory:"Process Termination" /Success:Enable
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit\ /v ProcessCreationIncludeCmdLine_Enabled /t REG_DWORD /d 1

echo Enabling powershell logging and transcript
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v EnableModuleLogging /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" /v * /t REG_SZ /d * /f /reg:64
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v EnableScriptBlockLogging /t REG_DWORD /d 00000001 /f /reg:64
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" /v EnableTranscripting /t REG_DWORD /d 00000001 /f /reg:64
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" /v OutputDirectory /t REG_SZ /d C:\PSTranscipts /f /reg:64
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" /v EnableInvocationHeader /t REG_DWORD /d 00000001 /f /reg:64

echo Enabling a bunch of auditing logs, success and failure
auditpol.exe /set /Category:* /success:enable
auditpol.exe /set /Category:* /failure:enable

echo Downloading and installing sysmon configs and sysmon.
powershell Invoke-WebRequest -Uri "https://raw.githubusercontent.com/olafhartong/sysmon-modular/master/sysmonconfig.xml" -OutFile "sysmonconfig.xml"
powershell Invoke-WebRequest -Uri "https://live.sysinternals.com/Sysmon.exe" -OutFile "sysmon.exe"
sysmon.exe -accepteula -i sysmonconfig.xml

echo Downloading winlogbeat
powershell Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-oss-7.9.3-windows-x86_64.zip" -OutFile "winlogbeat.zip"
powershell Expand-Archive -Path winlogbeat.zip -DestinationPath C:\loggingsetup\winlogbeat\

cd C:\loggingsetup\winlogbeat\winlogbeat-7.9.3-windows-x86_64\
PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-winlogbeat.ps1

sc start winlogbeat
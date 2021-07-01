Install-WindowsFeature -Name AD-Domain-Services, RSAT-AD-PowerShell, RSAT-AD-AdminCenter -IncludeManagementTools

$computerName = $env:COMPUTERNAME
$adminPassword = "Passw0rd!"
$adminUser = [ADSI] "WinNT://$computerName/Administrator,User"
$adminUser.SetPassword($adminPassword)

$PlainPassword = "Passw0rd!"
$SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

Import-Module ADDSDeployment
Install-ADDSForest `
    -SafeModeAdministratorPassword $SecurePassword `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "7" `
    -DomainName "TESTLAB.local" `
    -DomainNetbiosName "TESTLAB" `
    -ForestMode "7" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$true `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true

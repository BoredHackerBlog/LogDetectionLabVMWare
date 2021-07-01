$newDNSServers = "192.168.200.11"
$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -match "192.168.200."}
$adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}

$PlainPassword = "Passw0rd!"
$SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

$DomainCred = New-Object System.Management.Automation.PSCredential "TESTLAB.local\Administrator", $SecurePassword

Add-Computer -DomainName "TESTLAB.local" -credential $DomainCred

net localgroup Administrators TESTLAB.local\jsmith /add
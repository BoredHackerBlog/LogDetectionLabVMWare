Import-Module ActiveDirectory

New-ADUser -Name 'John Smith' -SAMAccountName jsmith -AccountPassword (ConvertTo-SecureString Password123 -AsPlainText -Force) -Description "john smith from it dept" -Enabled:$true
New-ADUser -Name 'Jane Doe' -SAMAccountName jdoe -AccountPassword (ConvertTo-SecureString 123Password -AsPlainText -Force) -Description "jane smith from it dept" -Enabled:$true
New-ADUser -Name 'SQL Service' -SAMAccountName SQLService -AccountPassword (ConvertTo-SecureString Servicepass123 -AsPlainText -Force) -Description "this is a service account with password servicepass123" -Enabled:$true

Add-ADGroupMember -Identity "Domain Admins" -Members jsmith, jdoe, SQLService
Add-ADGroupMember -Identity "Administrators" -Members jsmith, jdoe, SQLService
Add-ADGroupMember -Identity "Enterprise Admins" -Members jsmith, jdoe, SQLService

setspn -a dc1/SQLService.TESTLAB.local:60111 TESTLAB\SQLService
setspn -t TESTLAB.local -Q */*
New-Item 'C:\Shares\' -ItemType Directory
New-Item 'C:\Shares\SharedFiles' -ItemType Directory
New-SMBShare –Name "SharedFiles" –Path "C:\Shares\SharedFiles"
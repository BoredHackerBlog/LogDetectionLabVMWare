$path = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects'
try {
    $s = (Get-ItemProperty -ErrorAction stop -Name visualfxsetting -Path $path).visualfxsetting 
    if ($s -ne 2) {
        Set-ItemProperty -Path $path -Name 'VisualFXSetting' -Value 2  
        }
    }
catch {
    New-ItemProperty -Path $path -Name 'VisualFXSetting' -Value 2 -PropertyType 'DWORD'
    }

#source: https://social.technet.microsoft.com/Forums/windowsserver/en-US/73d72328-38ed-4abe-a65d-83aaad0f9047/adjust-for-best-performance?forum=winserverpowershell
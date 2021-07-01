Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-reload", "vagrant-vmware-desktop"]

  config.vm.provider "vmware_workstation" do |v|
    v.linked_clone = true
    v.memory = 2048
    v.cpus = 2
    v.gui = true
  end

  config.vm.define "dc1" do |dc1|
    dc1.vm.guest = :windows
    dc1.vm.communicator = "winrm"
    dc1.vm.boot_timeout = 600
    dc1.vm.graceful_halt_timeout = 600
    dc1.winrm.retry_limit = 200
    dc1.winrm.retry_delay = 10
    dc1.winrm.max_tries = 20
    dc1.winrm.transport = :plaintext
    dc1.winrm.basic_auth_only = true
    dc1.vm.box = "StefanScherer/windows_2019"
    dc1.vm.network "private_network", ip: "192.168.200.11"
    dc1.vm.network :forwarded_port, guest: 5985, host: 25985, id: "winrm"
    dc1.vm.network :forwarded_port, guest: 3389, host: 23389, id: "msrdp"
    dc1.vm.hostname = "dc1"
    # might have to change the interface name in the command below or ip address manually
    dc1.vm.provision "shell", privileged: false, inline: <<-SHELL
      netsh interface ipv4 set address name="Ethernet1" static 192.168.200.11 255.255.255.0
      netsh interface ipv4 set dns name="Ethernet1" static 192.168.200.11
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
      reg add HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64
    SHELL
    dc1.vm.provision "reload"
    dc1.vm.provision "shell", path: "install-dc.ps1", privileged: true
    dc1.vm.provision "reload"
    dc1.vm.provision "shell", path: "create-users.ps1", privileged: true
    dc1.vm.provision "shell", path: "create-smbshare.ps1", privileged: true
    dc1.vm.provision "shell", path: "change_ui.ps1", privileged: true
    dc1.vm.provision "shell", path: "change_sec_config.bat", privileged: true
    dc1.vm.provision "shell", path: "install-atomicredteam.ps1", privileged: true
    dc1.vm.provision "shell", path: "enable_logging.bat", privileged: true
    dc1.vm.provision "file", source: "winlogbeat.yml", destination: "C:\\loggingsetup\\winlogbeat\\winlogbeat-7.9.3-windows-x86_64\\winlogbeat.yml"
    dc1.vm.provision "shell", path: "setup_winlogbeat.bat", privileged: true
    dc1.vm.provision "reload"
  end
  
  config.vm.define "workstation1" do |workstation1|
    workstation1.vm.guest = :windows
    workstation1.vm.communicator = "winrm"
    workstation1.vm.boot_timeout = 600
    workstation1.vm.graceful_halt_timeout = 600
    workstation1.winrm.retry_limit = 200
    workstation1.winrm.retry_delay = 10
    workstation1.winrm.max_tries = 20
    workstation1.winrm.transport = :plaintext
    workstation1.winrm.basic_auth_only = true
    workstation1.vm.box = "StefanScherer/windows_10"
    workstation1.vm.network "private_network", ip: "192.168.200.12"
    workstation1.vm.network :forwarded_port, guest: 5985, host: 35985, id: "winrm"
    workstation1.vm.network :forwarded_port, guest: 3389, host: 33389, id: "msrdp"
    workstation1.vm.hostname = "labworkstation1"
    # might have to change the interface name in the command below or ip address manually
    workstation1.vm.provision "shell", privileged: false, inline: <<-SHELL
      netsh interface ipv4 set address name="Ethernet1" static 192.168.200.12 255.255.255.0
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
      reg add HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64
    SHELL
    workstation1.vm.provision "reload"
    workstation1.vm.provision "shell", path: "join-domain.ps1", privileged: true
    workstation1.vm.provision "shell", path: "create-smbshare.ps1", privileged: true
    workstation1.vm.provision "shell", path: "change_ui.ps1", privileged: true
    workstation1.vm.provision "shell", path: "change_sec_config.bat", privileged: true
    workstation1.vm.provision "shell", path: "install-atomicredteam.ps1", privileged: true
    workstation1.vm.provision "shell", path: "enable_logging.bat", privileged: true
    workstation1.vm.provision "file", source: "winlogbeat.yml", destination: "C:\\loggingsetup\\winlogbeat\\winlogbeat-7.9.3-windows-x86_64\\winlogbeat.yml"
    workstation1.vm.provision "shell", path: "setup_winlogbeat.bat", privileged: true
    workstation1.vm.provision "reload"
  end
  
  config.vm.define "kali" do |kali|
    kali.vm.box = "kalilinux/rolling"
    kali.vm.network "private_network", ip: "192.168.200.13"
    kali.vm.provision "reload"
  end

end
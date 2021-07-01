# LogDetectionLabVMWare
Vagrant AD Lab builder for log-based detection research and development

# virtualbox project https://github.com/BoredHackerBlog/LogDetectionLab 
# blog post (virtualbox is used): http://www.boredhackerblog.info/2021/01/creating-active-directory-ad-lab-for.html

# requirements
- any new 4 core 8 thread cpu should work
- 16 gigs of RAM should be fine too
- install vmware, vagrant, vagrant vmware utility (https://www.vagrantup.com/vmware/downloads), vagrant vmware plugin (vagrant plugin install vagrant-vmware-desktop)
- get a humio cloud account/ingest key

# usage
- run: git clone https://github.com/BoredHackerBlog/LogDetectionLabVMWare
- run: cd LogDetectionLabVMWare
- edit VMware provider (line: config.vm.provider "vmware_workstation" do |v|) if needed
- run: vagrant up
- walk away for like 30 minutes
- to destroy the lab, run: vagrant destroy -f

# services and creds
- for host to guest port forwarding configuration, check the vagrantfile
- user vagrant is on all the machines, login with vagrant / vagrant
- create-users.ps1 has more user info

# bugs
- check commit history to see what i fixed
- invoke-atomicredteam does get installed on workstation1 but Defender will remove some files.
- there may be more bugs. i didnt test this as much as i tested the virtualbox project

# resources i used to help me build this (there could be more that i missed. i had too many tabs open)
https://github.com/clong/DetectionLab

https://cyberdefenders.org/

https://github.com/cyberdefenders/DetectionLabELK

https://github.com/jckhmr/adlab

https://academy.tcm-sec.com/p/practical-ethical-hacking-the-complete-course

https://defensiveorigins.com/

https://defensiveorigins.com/trainings/

https://www.blackhillsinfosec.com/training/applied-purple-teaming-training/

https://app.vagrantup.com/StefanScherer

https://app.vagrantup.com/kalilinux/boxes/rolling

https://github.com/redcanaryco/atomic-red-team

https://atomicredteam.io/

https://github.com/redcanaryco/invoke-atomicredteam

https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon

https://github.com/olafhartong/sysmon-modular

https://www.humio.com/

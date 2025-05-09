
$BaseFolder  = [System.IO.Path]::Combine($ENV:USERPROFILE,"VirtualBox VMs")
$NICs        = Get-NetAdapter -Physical | Where-Object {$_.MediaType -ne 'Native 802.11'}
$OS          = [pscustomobject]@{Name='Kali'; Type='Debian_64'; ISO="V:\ISO\kali\kali-linux-2025.1c-installer-netinst-amd64.iso" }
$description = ( Get-Culture).TextInfo.ToTitleCase(([System.IO.Path]::GetFileNameWithoutExtension($OS.ISO) -replace "live", "") -split "-" )
## Temporarly  add the virtual box folder to the path 
if ( $env:Path -notmatch [regex]::Escape("$env:ProgramFiles\Oracle\VirtualBox\\") ) 
  { $env:Path = "$env:Path;$env:ProgramFiles\Oracle\VirtualBox\\"}

## Create Virtual Machina
VBoxManage createvm      --name $OS.name --register --basefolder $BaseFolder --ostype $OS.type
# 
Push-Location "$BaseFolder\$($OS.name)"

  # Create VDI (Virtual Disk Images) list for linux setup
  $disks       = @(
    [pscustomobject]@{ Name='root';   Size= 25600 }
    [pscustomobject]@{ Name='home';   Size= 30720 }
    [pscustomobject]@{ Name='swap';   Size= 10240 }
                  )
  ## Xreate the VDI defined in $disks 
  foreach ($disk in $disks) 
    { VBoxManage createmedium disk --format VDI --variant Standard --size $disk.Size --filename .\$($OS.name)_$($disk.Name).vdi }
  ## Chnage and Tweaks the Virtual Machine to optimal for Linux
  VBoxManage modifyvm      $OS.name --description $description
  VBoxManage modifyvm      $OS.name --memory 4096 --cpus 2 --chipset piix3 --firmware efi64 --pae on --paravirtprovider hyperv --longmode on 
  VBoxManage modifyvm      $OS.name --hwvirtex on --nestedpaging on --hpet off --triplefaultreset off --apic on --x2apic on --ioapic on 
  VBoxManage modifyvm      $OS.name --graphicscontroller vmsvga --vram 256 --accelerate3d on 
  VBoxManage modifyvm      $OS.name --clipboard bidirectional --draganddrop bidirectional 
  VBoxManage modifyvm      $OS.name --boot1 dvd --boot2 disk --boot3 none --boot4 none 
  VBoxManage modifyvm      $OS.name --usb on --usbxhci on --mouse usbtablet 
  #VBoxManage modifyvm      $OS.name --audiocontroller hda --audioout on 
  # Extra settings for host with Intel CPU
  if ( (Get-CimInstance -ClassName Win32_Processor).Name -match "Intel" ) 
    { VBoxManage modifyvm $OS.name --largepages on --vtxvpid on --vtxux on }
  ## Ctreate storage controllers for the virtual machine
  #VBoxManage storagectl    $OS.name --name "USB"    --add usb                        --portcount 8 --bootable on --hostiocache on
  VBoxManage storagectl    $OS.name --name "VirtIO" --add virtio --controller VirtIO --portcount 3 --bootable on --hostiocache on
  VBoxManage storagectl    $OS.name --name "NVMe"   --add pcie   --controller NVMe   --portcount 3 --bootable on --hostiocache on
  ## Attach the virtual machina to the virtual controller 
  VBoxManage storageattach $OS.name --storagectl "NVMe"   --port 0 --device 0 --type hdd --nonrotational on --discard on --medium .\$($OS.name)_root.vdi
  VBoxManage storageattach $OS.name --storagectl "NVMe"   --port 1 --device 0 --type hdd --nonrotational on --discard on --medium .\$($OS.name)_home.vdi
  VBoxManage storageattach $OS.name --storagectl "NVMe"   --port 2 --device 0 --type hdd --nonrotational on --discard on --medium .\$($OS.name)_swap.vdi
  VBoxManage storageattach $OS.name --storagectl "VirtIO" --port 2 --device 0 --type dvddrive --medium $OS.iso
  ## Create and tweak virtual network adapters as paravirtualized 
  $NICs.InterfaceDescription | Select-Object -First 4 | ForEach-Object -Begin { $i = 1 } -Process `
    { VBoxManage modifyvm $OS.name --nic$i bridged --nictype$i virtio --cableconnected$i on --bridgeadapter$i $_ ; $i++ }     
  ## 
  VBoxManage registervm    $OS.name
  ## Set the date for the VM setup 
  vboxmanage setextradata  $OS.name installdate $(Get-Date)
  ## Copy all VM configuration onto clipboard
  vboxmanage showvminfo    $OS.name | clip
  vboxmanage getextradata  $OS.name enumerate
  VBoxManage list vms
Pop-Location

VBoxManage modifyvm      $OS.name --groups "/linux"
#VBoxManage modifyvm      $OS.name --natdnshostresolver1 on
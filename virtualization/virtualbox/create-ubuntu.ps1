
$ISOimage   = "V:\ISO\AnduinOS\AnduinOS-1.3.1-en_US.iso"
$OS         = [pscustomobject]@{ Name = 'AnduinOS'; Type = 'Ubuntu_64' }
$BaseFolder = Join-Path $env:HOMEPATH "VirtualBox VMs"
$VMFolder   = Join-Path $BaseFolder $OS.Name
$NICs       = Get-NetAdapter -Physical | Where-Object { $_.MediaType -ne 'Native 802.11' } | Select-Object -First 4

if ( !(Get-Command VBoxManage.exe -ErrorAction SilentlyContinue)) { $env:Path += ";$env:ProgramFiles\Oracle\VirtualBox\" }

##  Create and Register VM  
VBoxManage createvm --name $OS.Name --register --basefolder "$BaseFolder" --ostype $OS.Type

##  Crete VM Folders
$disks = @(
  [pscustomobject]@{ Name = "$VMFolder\$($OS.Name)_root.vdi"; Size = 30720 }
  [pscustomobject]@{ Name = "$VMFolder\$($OS.Name)_home.vdi"; Size = 30720 }
  [pscustomobject]@{ Name = "$VMFolder\$($OS.Name)_swap.vdi"; Size = 12288 }
          )
foreach ($disk in $disks) { VBoxManage createmedium disk --format VDI --variant Standard --size $disk.Size --filename "$($disk.Name)" }

##  Set VM properties
VBoxManage modifyvm $OS.Name `
  --memory 4096 --cpus 2 --chipset piix3 --firmware efi64 --pae on --paravirtprovider hyperv --longmode on `
  --hwvirtex on --nestedpaging on --hpet on --triplefaultreset off --apic on --x2apic on --ioapic on `
  --graphicscontroller vmsvga --vram 256 --accelerate3d on `
  --clipboard bidirectional --draganddrop bidirectional `
  --boot1 dvd --boot2 disk --boot3 none --boot4 none `
  --usb on --usbxhci on --mouse usbtablet `

##  Set VM extra properties for Intel CPU
if ((Get-CimInstance -ClassName Win32_Processor).Name -match "Intel") { VBoxManage modifyvm $OS.Name --largepages on --vtxvpid on --vtxux on }

##  Add Storage Controllers
VBoxManage storagectl $OS.Name --name "USB"    --add usb    --portcount 8 --bootable on --hostiocache on
VBoxManage storagectl $OS.Name --name "NVMe"   --add pcie   --controller NVMe --portcount 3 --bootable on --hostiocache on
VBoxManage storagectl $OS.Name --name "VirtIO" --add virtio --controller VirtIO --portcount 3 --bootable on --hostiocache on

##  Attach virtual disks to Storage controllers
for ($i = 0; $i -lt $disks.Count; $i++) 
  { VBoxManage storageattach $OS.Name --storagectl "NVMe" --port $i --device 0 --type hdd --nonrotational on --discard on --medium "$($disks[$i].Name)" }
VBoxManage storageattach $OS.Name --storagectl "VirtIO" --port 2 --device 0 --type dvddrive --medium "$ISOimage"

##  Create network adapters
for ($i = 0; $i -lt $NICs.Count; $i++) 
  { $nic = $NICs[$i].InterfaceDescription; VBoxManage modifyvm $OS.Name --nic$($i+1) bridged --nictype$($i+1) virtio --bridgeadapter$($i+1) "$nic" }

## Set Extra VM properties
VBoxManage modifyvm $OS.Name --groups "/linux"
vboxmanage setextradata $OS.name installdate $(Get-Date)
VBoxManage setextradata $OS.name "VBoxInternal2/Keyboard/UseLegacy" 1
#VBoxManage setextradata $OS.name "VBoxInternal/Devices/pcbios/0/Config/KeyboardMouseIntegration" 1
#VBoxManage setextradata $OS.name "VBoxInternal2/CoreInput/UseKeyboardPolling" 1

VBoxManage showvminfo $OS.Name | clip

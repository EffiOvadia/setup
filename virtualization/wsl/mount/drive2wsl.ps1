
function Attach-Disk 
{
  $disks = Get-CimInstance -Query "SELECT * from Win32_DiskDrive" | Sort-Object DeviceID |
    Select-Object DeviceID, Model, @{Name="Size(GB)"; Expression={"{0,8:N2}" -f ($_.Size/1GB)}}

  $disk = $disks | Out-GridView -OutputMode Single -Title "Select a disk to attach to WSL"
  
  # wsl --mount $disk.DeviceID --bare
}  

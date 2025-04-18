
function Attach-Disk 
{
  $disks = Get-CimInstance -Query "SELECT * from Win32_DiskDrive" | Sort-Object DeviceID |
    Select-Object DeviceID, Model, @{Name="Size(GB)"; Expression={"{0,8:N2}" -f ($_.Size/1GB)}}

  $disks | Format-Table -AutoSize
  
  wsl --mount $disk.DeviceID --bare 
}  

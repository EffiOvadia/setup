
Get-Service -Name w32time -ErrorAction SilentlyContinue | Restart-Service
Set-Service -Name w32time -StartupType Automatic
w32tm /config /manualpeerlist:"il.pool.ntp.org, timeserver.iix.net.il" /syncfromflags:manual /reliable:YES /update
w32tm /resync
w32tm /query /status

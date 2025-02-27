$threshold = 10GB
$drives = Get-PSDrive -PSProvider FileSystem
foreach ($drive in $drives) 
  {if ($drive.Free -lt $threshold) 
    {Send-MailMessage -To "admin@domain.com" -From "monitor@domain.com" -Subject "Disc Space Alert" -Body "Drive $($drive.Name) is running low on space." -SmtpServer "smtp.domain.com"}}
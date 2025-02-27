# Get all local users
Write-Host "All local users:" -ForegroundColor Cyan
Get-LocalUser | Format-Table Name, Enabled, LastLogon
# Get a specific user by name
$specificUser = "Administrator"
Write-Host "`nDetails for user '$specificUser':" -ForegroundColor Cyan
Get-LocalUser -Name $specificUser | Format-List Name, FullName, Enabled, LastLogon, PasswordLastSet, PasswordExpires
# Get disabled users
Write-Host "`nDisabled users:" -ForegroundColor Cyan
Get-LocalUser | Where-Object { -not $_.Enabled } | Format-Table Name, LastLogon
# Get users who haven't logged in for the last 30 days
$thirtyDaysAgo = (Get-Date).AddDays(-30)
Write-Host "`nUsers who haven't logged in for 30 days:" -ForegroundColor Cyan
Get-LocalUser | Where-Object { $_.LastLogon -lt $thirtyDaysAgo -and $_.Enabled } | Format-Table Name, LastLogon
# Get users with passwords that never expire
Write-Host "`nUsers with passwords that never expire:" -ForegroundColor Cyan
Get-LocalUser | Where-Object { $_.PasswordExpires -eq $null } | Format-Table Name, PasswordLastSet
# Export all user information to CSV
$csvPath = "$env:USERPROFILE\Desktop\LocalUsers.csv"
Get-LocalUser | Select-Object Name, Enabled, LastLogon, PasswordLastSet, PasswordExpires |
Export-Csv -Path $csvPath -NoTypeInformation
Write-Host "`nLocal user information exported to: $csvPath" -ForegroundColor Green
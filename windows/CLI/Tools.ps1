#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

## ----- Free Software -----------------------------------
$Apps = 
  @(
  [PSCustomObject]@{Name='Teamviewer'; ID='TeamViewer.TeamViewer'}
  [PSCustomObject]@{Name='RDP'; ID='Microsoft.RemoteDesktopClient'}
  [PSCustomObject]@{Name='AnyDesk'; ID='AnyDeskSoftwareGmbH.AnyDesk'}
  [PSCustomObject]@{Name='Microsoft PowerToys'; ID='Microsoft.Powertoys'}
  [PSCustomObject]@{Name='qBittorrent'; ID='qBittorrent.qBittorrent'}
  [PSCustomObject]@{Name='KeepassXC'; ID='KeePassXCTeam.KeePassXC'}
  [PSCustomObject]@{Name='Keepass'; ID='DominikReichl.KeePass'}
  [PSCustomObject]@{Name='Balena Etcher'; ID='Balena.Etcher'}
  [PSCustomObject]@{Name='OneDrive'; ID='Microsoft.OneDrive'}
  [PSCustomObject]@{Name='Google Drive'; ID='Google.Drive'}
  [PSCustomObject]@{Name='Dropbox'; ID='Dropbox.Dropbox'}
  [PSCustomObject]@{Name='VLC'; ID='XPDM1ZW6815MQM'}
  [PSCustomObject]@{Name='7-Zip'; ID='7zip.7zip'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}
## -------------------------------------------------------
winget upgrade --all --include-unknown --silent --verbose
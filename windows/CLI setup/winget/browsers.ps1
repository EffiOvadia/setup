#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

## ----- Browsers & eMail Client -------------------------
$Apps = 
  @(
  [PSCustomObject]@{Name='Brave Browser'; ID='Brave.Brave'}
  [PSCustomObject]@{Name='Opera Browser'; ID='Opera.Opera'}
  [PSCustomObject]@{Name='Edge Browser'; ID='XPFFTQ037JWMHS'}
  [PSCustomObject]@{Name='Firefox Browser'; ID='Mozilla.Firefox'}
  [PSCustomObject]@{Name='Tor Browser'; ID='TorProject.TorBrowser'}
  [PSCustomObject]@{Name='Waterfox Browser'; ID='Waterfox.Waterfox'}
  [PSCustomObject]@{Name='Google Chrome Browser'; ID='Google.Chrome'}
  [PSCustomObject]@{Name='LibreWolf Browser'; ID='LibreWolf.LibreWolf'}
  [PSCustomObject]@{Name='Vivaldi Browser'; ID='VivaldiTechnologies.Vivaldi'}
  [PSCustomObject]@{Name='BetterBird Mail Client'; ID='Betterbird.Betterbird'}
  [PSCustomObject]@{Name='Thunderbird Mail Client'; ID='Mozilla.Thunderbird'}
  )

foreach ( $App in $Apps ) 
  { winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID }

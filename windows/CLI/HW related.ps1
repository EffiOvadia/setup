#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

## ----- 3rdparty tools  -----------------------------------
$Apps = 
  @(
  [PSCustomObject]@{Name='YubiKey Personalization'; ID='Yubico.YubiKeyPersonalizationTool'}
  [PSCustomObject]@{Name='Yubico Authenticator'; ID='Yubico.Authenticator'}
  [PSCustomObject]@{Name='Yubikey Manager'; ID='Yubico.YubikeyManager'}
  [PSCustomObject]@{Name='Samsung SmartSwitch'; ID='Samsung.SmartSwitch'}
  [PSCustomObject]@{Name='Samsung SmartView'; ID='Samsung.SmartView'}
  [PSCustomObject]@{Name='Samsung DeX'; ID='Samsung.DeX'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}
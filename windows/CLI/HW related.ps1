#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

## ----- 3rdparty tools  -----------------------------------
$Apps = 
  @(  
  [PSCustomObject]@{Name='Samsung DeX'; ID='Samsung.DeX'}
  [PSCustomObject]@{Name='Logitech.LogiBolt'; ID='Logitech.LogiBolt'}
  [PSCustomObject]@{Name='Logitech OptionsPlus'; ID='Logitech.OptionsPlus'}
  [PSCustomObject]@{Name='Intel Driver Assistant'; ID='Intel.IntelDriverAndSupportAssistant'}
  [PSCustomObject]@{Name='YubiKey Personalization'; ID='Yubico.YubiKeyPersonalizationTool'}
  [PSCustomObject]@{Name='Yubico Authenticator'; ID='Yubico.Authenticator'}
  [PSCustomObject]@{Name='Yubikey Manager'; ID='Yubico.YubikeyManager'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}
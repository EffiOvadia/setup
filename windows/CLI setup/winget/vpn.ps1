#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

#! ----- VPN -------------------------------------

$Apps = 
  @(
  #[PSCustomObject]@{Name='ProtonVPN'; ID='ProtonTechnologies.ProtonVPN'}
  [PSCustomObject]@{Name='OpenVPN'; ID='OpenVPNTechnologies.OpenVPN'}
  #[PSCustomObject]@{Name='Cloudflare Warp'; ID='Cloudflare.Warp'}
  [PSCustomObject]@{Name='WireGuard'; ID='WireGuard.WireGuard'}
  #[PSCustomObject]@{Name='Tutanota'; ID='Tutanota.Tutanota'}
  #[PSCustomObject]@{Name='OutlineManager'; ID='Jigsaw.OutlineManager'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}

#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

## ----- Productivity ------------------------------------
$Apps = 
  @(
  [PSCustomObject]@{Name='LibreOffice'; ID='TheDocumentFoundation.LibreOffice'}
  #[PSCustomObject]@{Name='Adobe Acrobat Reader'; ID='Adobe.Acrobat.Reader.64-bit'}
  [PSCustomObject]@{Name='Clipchamp'; ID='Clipchamp.Clipchamp_yxz26nhyzhsrt'}
  [PSCustomObject]@{Name='Adobe DNG Converter'; ID='Adobe.DNGConverter'}
  [PSCustomObject]@{Name='OnlyOffice'; ID='ONLYOFFICE.DesktopEditors'}
  [PSCustomObject]@{Name='IrfanView'; ID='IrfanSkiljan.IrfanView'}
  [PSCustomObject]@{Name='Obsidian'; ID='Obsidian.Obsidian'}
  [PSCustomObject]@{Name='Joplin'; ID='Joplin.Joplin'}
  [PSCustomObject]@{Name='Inkscape'; ID='9PD9BHGLFC7H'}
  #[PSCustomObject]@{Name='Gimp'; ID='XPDM27W10192Q0'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}

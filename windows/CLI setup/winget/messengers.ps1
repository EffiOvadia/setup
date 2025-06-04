#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

#! ----- Communications ----------------------------------

$Apps = 
  @(
  #[PSCustomObject]@{Name='Discord'; ID='Discord.Discord'}
  [PSCustomObject]@{Name='WhatsApp'; ID='WhatsApp.WhatsApp'}
  #[PSCustomObject]@{Name='HexChat'; ID='HexChat.HexChat'}
  [PSCustomObject]@{Name='Teams'; ID='Microsoft.Teams'}
  [PSCustomObject]@{Name='Zoom'; ID='Zoom.Zoom'}
  [PSCustomObject]@{Name='Signal'; ID='OpenWhisperSystems.Signal'}
  [PSCustomObject]@{Name='Telegram'; ID='Telegram.TelegramDesktop'}
  [PSCustomObject]@{Name='Facebook'; ID='FACEBOOK.FACEBOOK_8xx8rvfyw5nnt'}
  [PSCustomObject]@{Name='Twitter'; ID='9E2F88E3.TWITTER_wgeqdkkx372wm'}
  [PSCustomObject]@{Name='LocalSend'; ID='LocalSend.LocalSend'}
  #[PSCustomObject]@{Name='WeChat'; ID='Tencent.WeChat'}
  #[PSCustomObject]@{Name='LINE'; ID='LINE.LINE'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}

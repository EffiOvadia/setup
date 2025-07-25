#! https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1
#! https://github.com/microsoft/winget-cli/releases/latest
#! https://aka.ms/getwinget
#! ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

#! ----- Development -------------------------------------

$Apps = 
  @(
  [PSCustomObject]@{Name='PowerShell'; ID='Microsoft.PowerShell'}
  [PSCustomObject]@{Name='Windows Terminal'; ID='Microsoft.WindowsTerminal'}
  [PSCustomObject]@{Name='Midnight Commander'; ID='GNU.MidnightCommander'}
  #[PSCustomObject]@{Name='GitHub Desktop'; ID='GitHub.GitHubDesktop'}
  [PSCustomObject]@{Name='VSCode'; ID='Microsoft.VisualStudioCode'}
  #[PSCustomObject]@{Name='VSCodium'; ID='VSCodium.VSCodium'}
  #[PSCustomObject]@{Name='Cygwin'; ID='Cygwin.Cygwin'}
  [PSCustomObject]@{Name='Neovim'; ID='Neovim.Neovim'}
  [PSCustomObject]@{Name='WinSCP'; ID='WinSCP.WinSCP'}
  [PSCustomObject]@{Name='PuTTY'; ID='PuTTY.PuTTY'}
  [PSCustomObject]@{Name='Wget2'; ID='GNU.Wget2'}
  [PSCustomObject]@{Name='cURL'; ID='cURL.cURL'}
  [PSCustomObject]@{Name='VIM'; ID='vim.vim'}
  [PSCustomObject]@{Name='Git'; ID='Git.Git'}
  [PSCustomObject]@{Name='lsd'; ID='lsd-rs.lsd'}
  [PSCustomObject]@{Name='7zip'; ID='7zip.7zip'}
  #[PSCustomObject]@{Name='Emacs'; ID='GNU.Emacs'}
  #[PSCustomObject]@{Name='Yazi'; ID='sxyazi.yazi'}
  #[PSCustomObject]@{Name='Helix'; ID='Helix.Helix'}
  #[PSCustomObject]@{Name='GitHub.cli'; ID='GitHub.cli'}
  #[PSCustomObject]@{Name='Warp Terminal'; ID='Warp.Warp'}
  #[PSCustomObject]@{Name='Lazygit'; ID='JesseDuffield.lazygit'} 
  #[PSCustomObject]@{Name='FarManager'; ID='FarManager.FarManager'}
  #[PSCustomObject]@{Name='ImageMagick'; ID='ImageMagick.ImageMagick'}
  #[PSCustomObject]@{Name='Wireshark'; ID='WiresharkFoundation.Wireshark'}
  #[PSCustomObject]@{Name='VMware Workstation Pro'; ID='VMware.WorkstationPro'}
  #[PSCustomObject]@{Name='VirtualBox'; ID='Oracle.VirtualBox'}
  )

foreach ($App in $Apps) 
  {winget install --accept-package-agreements --accept-source-agreements --exact --ID $App.ID}

#! ----- Set GH_EDITOR for VSCode ------------------------

if (Get-Command code -ErrorAction SilentlyContinue) 
  {[System.Environment]::SetEnvironmentVariable("GH_EDITOR", "code --wait", "User")}

gh extension install github/gh-copilot
gh extension install github/gh-autofix

SUDO=() ; (( EUID == 0 )) || SUDO=(sudo)

# Enable SSH on mac
"${SUDO[@]}" systemsetup -setremotelogin on

# Set computer name, local hostname, and hostname to "pixie"
"${SUDO[@]}" scutil --set ComputerName "pixie"
"${SUDO[@]}" scutil --set LocalHostName "pixie"
"${SUDO[@]}" scutil --set HostName "pixie"
# Verify the changes
scutil --get ComputerName
scutil --get LocalHostName
scutil --get HostName


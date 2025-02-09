#!/bin/bash

### ---------------------------------------
### Check for installed interactive shells:
cat /etc/shells
### Check the current shell for a user:
grep effio /etc/passwd
### ---------------------------------------
### Change user's shell in /etc/passwd using usermod command:
usermod --shell /bin/tmux effio
### Alternativly change users shell vis chsh:
# chsh --shell $(which tmux) effio
# chsh --shell $(which zsh) effio 
###  Applications such as: mc, htop, mutt
###  can be used as a alternate shell either directly from password file,
###  or cascatded to TMUX 
###  e.g. :   set-option -g default-shell /bin/mc
###  will start the midnight commander on top of tmux
### ---------------------------------------
### Chnage the default shell to tmux
sed -i 's/[# ].*default-shell.*/set-option -g default-shell \/bin\/bash/g'  ~/.tmux.conf
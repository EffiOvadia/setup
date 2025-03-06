#!/bin/bash

# Check for installed interactive shells:
#cat /etc/shells
# Check the current shell for a user:
#grep effio /etc/passwd
# Change user's shell in /etc/passwd using usermod command:
#usermod --shell /bin/tmux effio
# Alternativly change users shell via chsh:
chsh --shell $(which tmux) effio
# chsh --shell $(which zsh) effio 

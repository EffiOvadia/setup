#!/bin/bash

# Check for installed interactive shells:
cat /etc/shells
# Change user's shell using usermod command:
usermod --shell "$(which screen)" $(whoami)
# Alternativly change users shell via chsh:
chsh --shell $(which tmux) $(whoami)

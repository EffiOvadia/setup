#!/bin/bash

### Setting VGA fonts
sed -i.bak \
     -e 's/[# ]*ACTIVE_CONSOLES=.*/ACTIVE_CONSOLES="\/dev\/tty\[1-6\]"/g' \
     -e 's/[# ]*CHARMAP=.*/CHARMAP="UTF-8"/g' \
     -e 's/[# ]*CODESET=.*/CODESET="guess"/g' \
     -e 's/[# ]*FONTFACE=.*/FONTFACE="TerminusBold"/g' \
     -e 's/[# ]*FONTSIZE=.*/FONTSIZE="16x28"/g' \
          /etc/default/console-setup

### dpkg-reconfigure console-setup

systemctl restart console-setup
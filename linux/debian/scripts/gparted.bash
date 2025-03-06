#!/bin/bash

# Install GParted if not installed
sudo dpkg -s gparted >& /dev/null || sudo apt install -y gparted
# create GParted no password rule
sudo \cat > /etc/polkit-1/rules.d/49-gparted-nopasswd.rules <<-'EOF'
polkit.addRule(function(action, subject) { if (subject.isInGroup("wheel") && action.id == "org.gnome.gparted") 
    { return polkit.Result.YES; }});
EOF

sudo systemctl restart polkit
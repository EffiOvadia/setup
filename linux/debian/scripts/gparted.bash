#!/bin/bash

sudo \cat > /etc/polkit-1/rules.d/49-gparted-nopasswd.rules <<-'EOF'
polkit.addRule(function(action, subject) { if (subject.isInGroup("wheel") && action.id == "org.gnome.gparted") 
    { return polkit.Result.YES; }});
EOF

sudo systemctl restart polkit
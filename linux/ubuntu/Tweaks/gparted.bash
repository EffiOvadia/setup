#!/bin/bash

sudo \cat > /etc/polkit-1/rules.d/49-nopasswd.rules <<-EOF
polkit.addRule(function(action, subject) {
    if (subject.user == "effio") {
        return polkit.Result.YES;
    }
});
EOF

sudo systemctl restart polkit

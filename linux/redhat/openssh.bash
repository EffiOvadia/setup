#!/usr/bin/env bash

sudo yum update -y


sudo yum install -y openssh-server rsync
sudo systemctl enable sshd
sudo systemctl start sshd
sudo systemctl status sshd

sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

sed -i -e 's/[# ]*Port .*/Port 22/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

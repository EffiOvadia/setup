#!/usr/bin/env bash

apt install -y samba

if [ -d /home/public ] ; then chmod 777 /home/public -R; else mkdir -m 777 -p /home/public; fi
chown effio:sudo /home/public -R 

if [ -d /home/public ]; then 
\cat >> /etc/samba/smb.conf <<-EOF

[Public]
   comment = Public folders
   path = /home/public
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0666
   directory mask = 0777
EOF
fi

if [ -d /home/effio ]; then
\cat >> /etc/samba/smb.conf <<-EOF

[Effi Ovadia]
   comment = Effi Ovadia home folder
   path = /home/effio
   browseable = yes
   valid users = effio
   read only = no
EOF
fi

if [ -d /archive ]; then
\cat >> /etc/samba/smb.conf <<-EOF

[Archive]
   comment = Archive
   path = /archive
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0666
   directory mask = 0777
EOF
fi

if [ -d /home/ultrabase ]; then
\cat >> /etc/samba/smb.conf <<-EOF

[UltraBase]
   comment = UltraBase
   path = /ultrabase
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0666
   directory mask = 0777
EOF
fi

### add linux user to samba
# smbpasswd -a effio
### remove linux user from samba
# smbpasswd -x effio
systemctl restart smbd

### -----------------------------------------------------------------------------------------
### -----------------------------------------------------------------------------------------
### mount \\\\192.168.2.220\\public /server/public -t cifs -o "username=effio,password=Dalya1944"


#!/usr/bin/env bash

systemctl restart vmtoolsd

sed -i \
  's/[# ]*MODULES=.*/MODULES=(vsock vmw_vsock_vmci_transport vmw_balloon vmw_vmci vmwgfx)/g' /etc/mkinitcpio.conf
          
mkinitcpio -P
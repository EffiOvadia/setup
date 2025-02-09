#!/bin/bash

sudo sed -i 's/[# ]*COMPRESS=.*/COMPRESS=gzip/g' /etc/initramfs-tools/initramfs.conf
sudo update-initramfs -u

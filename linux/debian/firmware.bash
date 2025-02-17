#!/usr/bin/env bash

apt install --assume-yes firmware-misc-nonfree && update-initramfs -c -k all
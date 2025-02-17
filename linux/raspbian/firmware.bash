#!/usr/bin/env bash

apt install rpi-update
echo Y | rpi-update
raspi-config
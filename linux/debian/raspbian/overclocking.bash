#!/usr/bin/env bash

sudo \cat >> /boot/firmware/config.txt <<-'EOF'
arm_freq=2000
gpu_freq=600
over_voltage=6
arm_freq_min=600
EOF

watch -n 1 vcgencmd measure_clock arm

### check clock speed
vcgencmd measure_clock arm
### check temperture
vcgencmd measure_temp
### check voltage
vcgencmd measure_volts
### check if the system throttled
vcgencmd get_throttled

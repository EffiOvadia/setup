#!/usr/bin/env bash

sudo \cat >> /boot/firmware/config.txt <<-'EOF'
arm_freq=2000
gpu_freq=600
over_voltage=6
arm_freq_min=600
EOF

watch -n 1 vcgencmd measure_clock arm

## check clock speed
vcgencmd measure_clock arm
## check temperture
vcgencmd measure_temp
## check voltage
vcgencmd measure_volts
## check if the system throttled
vcgencmd get_throttled

##################################

sed -Ei "/^# OC settings/,/^# end/d" /boot/firmware/config.txt
cat >>/boot/firmware/config.txt <<EOF
## OC settings
gpu_mem=16           # GPU ram for server mode
arm_boost=0          # Disable automatic Boost
arm_freq=1300        # 1.375 GHz CPU
core_freq=450        # L2/VPU
sdram_freq=450       # DDR
over_voltage=3       # +0.3 V
temp_soft_limit=70   # limit for temperature throttling
## end 
EOF

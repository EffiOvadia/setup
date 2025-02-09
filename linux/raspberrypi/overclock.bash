
sed -i 's/[# ]*arm_freq=.*/arm_freq=1750/g' /boot/config.txt

over_voltage=2

watch -n 1 vcgencmd measure_clock arm


### check clock speed
vcgencmd measure_clock arm
### check temperture
vcgencmd measure_temp
### check voltage
vcgencmd measure_volts
### check if the system throttled
vcgencmd get_throttled


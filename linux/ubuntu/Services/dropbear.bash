### Configuring Dropbear SSH server
apt install -y dropbear 

sed -i \
     -e 's/[# ]*NO_START=.*/NO_START=0/g' \
     -e 's/[# ]*DROPBEAR_PORT=.*/DROPBEAR_PORT=22122/g' \
     -e 's/[# ]*DROPBEAR_EXTRA_ARGS=.*/DROPBEAR_EXTRA_ARGS="-s"/g' \
          /etc/default/dropbear

cat > /etc/dropbear-initramfs/authorized_keys <<-EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEA5Cy6NxhdKrNxMVgUf8P4MV+4fmtff3ySgppFHLd37C3A4XZy3qh+F1tp6H1WPgMfwnhyN1O9jCkB9IjvVvggmjxj0JY5+ke5JE0Ti55Ng58x/pDkdojc2le7Bzx7nopTEPeGr/E4BE2nwMuVD6G40wSZ9jN/9qJbCXE0/TBgneOwxuFw8aeAQFp1ZEEzzHoe384fw4HDIFMnqmnueirj/yMCK1FFTz5hO6nxHwF3lPZG0+Nm5y4P1v8kbdKg7jEZAsdmGq7+RgE4LnqGmrhSYRSY+XWqpAMhw7xIUVYQVeg6n7EEDT4m1dTUwqNCwoX6aTalZ+w1C/sZSqGy2+DiXYM/iRk5TnYlHIc5VvIMfOXLm60EwqulrfmblF5XN3QT7TYFhXl82AdZw+r9U1Q1aD9pLFEWPxelJq7udO4eKLHpYWeq2TU2Zt8JyLCBHDxs60hUn14175xQp626R3nhXZVcxJf01mZ+auOQaAGeSXVK/h0MXFFeDU+0gRiapBoXOz+hCH+CCEVKWYOZTpcT9/ZYn5gVBtIgKVoUKJx/RVH8YfuwMd8osjzTe73LVIhIN3t+H1v4wIKLeTe+LcHIp9JtrC90THVzVOp1Vypmn0DNkk5Qz3EbPlK3K5vHeGlUSLyRCe9/qj+ZWj/SgExvr3xthpoV4Wlprg9OsdyZBEs= 9a:6e:0a:00:f5:52:7b:2e:c7:24:d2:43:92:6b:52:59 @Appliances (RSA 4096)
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEAmQ4lXbqBWxpHCigKFYrrD4j/pH/ZhK9J/7aP2gRUIRTiZ0sMKpLCSjP5ldLOMQVKjnnCDZaVEim7MHS5s65bIwLmYKuqXbMOppVGnET6YuwjZ43tycK7MoGaefvZ3nB9uzqz+pOxTRwx+XNfhoGpjAz4WOdzewUPEy/Gk0iiG0fFywgH8inzxYzrTn2ZxGwTSHuEhbOL9XFKloRZb1Nh+6SHJnH0dT8BftSW0ab/aLyQziwi8ymvNC6hqD1dq0j7jgT/qgcuboUYaGX9lHGT5QQDyzp+nj4K/GotkISP1O8chCaHkzHMCBEuboOxJJABJWBiZf5RALP3q1dyURh7WUzyDuYblfsNHM//K3vf9nnVg0ncEgJOG7zaiE5WKvJGebNQ3veeUhCaXzMMEVfaL5ZL3txQcYJQqb4AGkBpJnZHslXkuOOeOsmiMXnBQKwvDRZsCID0S/7IEhQXH/XzNjnMk6Dx8qz5h0X8a645a087AJWbnNkzTGNdeZ6M+dosj3VC2LUNDSnpCuObOyXxSX28HuwmTM3Y9OHW4WdQa9r/B69Ge1x+49Hmvjp6+ZZv2JL9yrPKb/xeuVgeWDEFpRAyPT+wwEuuHiGaBIrPGaA+9IunMy/Nl0T52MJc0KEbBNYPWEVq0uvUDCnboPmnALo9B/s4leF1UOH9h7MvxWs= f3:e5:fd:a0:2d:3d:2d:bf:2f:57:f1:63:08:b2:eb:8b @Routers (RSA 4096)
EOF

### -----------------------------------------------------------------
### Check if Active & enabled
systemctl is-active dropbear
systemctl is-enabled dropbear
### Activate & Enable Dropbear
systemctl enable --now dropbear
### Restart dropbear for changes to apply changes 
systemctl restart dropbear.service
netstat -ntulp | grep dropbear

sudo usermod -aG sudo avraham

# Update the package list
sudo apt update

# Install the Hebrew language pack
sudo apt install -y language-pack-he

# Set Hebrew as a supported language
sudo update-locale LANG=he_IL.UTF-8

# Generate locale for Hebrew
sudo locale-gen he_IL.UTF-8

# Reconfigure locales to ensure the changes are applied
sudo dpkg-reconfigure locales

# Reboot or log out and log back in for the changes to take effect
sudo reboot

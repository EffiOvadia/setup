sudo apt update
sudo apt install tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up
tailscale status


# sudo tailscale down

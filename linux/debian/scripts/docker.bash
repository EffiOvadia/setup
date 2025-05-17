#!/usr/bin/env bash

## Docker Setup

# cleanup
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt-get remove $pkg; done

apt update
#apt install --install-suggests gnome-software
apps=( docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin )
apt install ${apps[@]}
docker run hello-world
#!/bin/bash

APT_URL="https://download.vscodium.com/debs"
APT_FILE="/etc/apt/sources.list.d/vscodium.list"

GPG_URL="https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg"
GPG_FILE="/usr/share/keyrings/vscodium-archive-keyring.gpg"

# Add the GPG key of the repository:
if [ ! -f "$GPG_FILE" ]
then
    wget -qO - "$GPG_URL" | gpg --dearmor | sudo dd of="$GPG_FILE"
fi

# Add the repository:
if [ ! -f "$APT_FILE" ]
then
    echo "deb [ signed-by=$GPG_FILE ] $APT_URL vscodium main" | sudo tee "$APT_FILE"
fi

# Install vscodium
sudo apt-get update
sudo apt-get install -y codium


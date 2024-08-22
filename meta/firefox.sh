#!/bin/bash

APT_URL="https://packages.mozilla.org/apt"
APT_FILE="/etc/apt/sources.list.d/mozilla.list"

PREFERENCES_FILE="/etc/apt/preferences.d/mozilla"

GPG_URL="https://packages.mozilla.org/apt/repo-signing-key.gpg"
GPG_FILE="/etc/apt/keyrings/packages.mozilla.org.asc"

# Add the GPG key of the repository:
if [ ! -f "$GPG_FILE" ]
then
    wget -q "$GPG_URL" -O- | sudo tee "$GPG_FILE" > /dev/null
    gpg -n -q --import --import-options import-show "$GPG_FILE" | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
fi

# Add the repository:
if [ ! -f "$APT_FILE" ]
then
    echo "deb [signed-by=$GPG_FILE] $APT_URL mozilla main" | sudo tee -a "$APT_FILE" > /dev/null
fi

# prioritize packages
if [ ! -f "$PREFERENCES_FILE" ]
then
    echo "Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n" | sudo tee "$PREFERENCES_FILE"
fi

# Install vscodium
sudo apt-get update
sudo apt-get install -y codium


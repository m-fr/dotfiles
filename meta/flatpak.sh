#!/bin/bash

command -v flatpak > /dev/null || (echo "This system is not using APT package manager" && exit 1)

[[ -f "$1" ]] || (echo "Packages file not found" && exit 1)

for item in $(cat $1)
do
    [[ -z "$item" ]] && continue
    [[ "${item:0:1}" == "#" ]] && continue

    echo "Installing $item"
    flatpak install --or-update -y flathub $item || echo -e "\e[31m$item installation failed\e[0m"
done

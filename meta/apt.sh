#!/bin/bash

command -v apt > /dev/null || (echo "This system is not using APT package manager" && exit 1)

[[ -f "$1" ]] || (echo "Packages file not found" && exit 1)

sudo apt-get update

for item in $(cat $1)
do
    [[ -z "$item" ]] && continue
    [[ "${item:0:1}" == "#" ]] && continue

    echo "Installing $item"
    sudo apt-get install -y $item || echo -e "\e[31m$item installation failed\e[0m"
done

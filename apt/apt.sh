#!/bin/bash

command -v apt > /dev/null || (echo "This system is not using APT package manager" && exit 1)

[[ -f "$1" ]] || (echo "Packages file not found" && exit 1)

sudo apt update /dev/null

for item in $(cat $1)
do
    echo "Installing $item"
    sudo apt install $item > /dev/null || echo -e "\e[31m$item installation failed\e[0m"
done

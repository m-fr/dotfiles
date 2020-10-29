#!/bin/sh

updates=$(apt list --upgradable 2> /dev/null | grep -c upgradable);

case $1 in
'-l')
    apt list --upgradable | tail -n +2 | rofi -dmenu -location 3
    ;;
*)
    if [ "$updates" -gt 0 ]; then
        echo " $updates"
    else
        echo ""
    fi
esac

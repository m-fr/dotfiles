#!/bin/bash

status="$(amixer get Master | awk -F'[][]' '/%/{print $4;exit}')"

if [ "$status" = "off" ]; then
    amixer -q set Master unmute
elif [ "$status" = "on" ]; then
    amixer -q set Master mute
fi

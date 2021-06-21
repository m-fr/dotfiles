#!/bin/bash

# Terminate already running bar instances
killall -q polybar
rm -f /tmp/ipc-bar*

for BAR in $(polybar -m | cut -d: -f1)
do
    if [ "$BAR" == "$MON_PRIMARY" ]; then
        polybar primary >>/tmp/polybar.$BAR.log 2>&1 &
    else
        polybar secondary >>/tmp/polybar.$BAR.log 2>&1 &
    fi
    ln -s /tmp/polybar_mqueue.$! /tmp/ipc-bar$BAR
done

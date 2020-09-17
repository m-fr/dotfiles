#!/bin/bash

# Terminate already running bar instances
killall -q polybar
rm -f /tmp/ipc-bar*

for BAR in $(polybar -m | cut -d- -f1)
do
    polybar bar$BAR >>/tmp/polybar.$BAR.log 2>&1 &
    ln -s /tmp/polybar_mqueue.$! /tmp/ipc-bar$BAR
done

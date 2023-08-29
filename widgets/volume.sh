#!/bin/bash

vol=`amixer get Master | grep 'Left:' | cut -d'[' -f2 | cut -d'%' -f1`
mute=`amixer get Master | grep 'Left:' | cut -d'[' -f3 | cut -d']' -f1`

if [[ $mute == "on" ]]; then
    echo $vol
else
    echo "x"
fi

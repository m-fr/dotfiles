#!/bin/bash

shortcuts=$HOME/.config/.shortcuts/
app=`ls $shortcuts | rofi -dmenu -i -no-show-icons -width 1000`

if [[ "$app" ]]; then
    cat ~/.config/.shortcuts/$app | \
    awk '/^[^#]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | \
    column -t -s $'\t' | \
    rofi -dmenu -i -no-show-icons -width 1000
fi

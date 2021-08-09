#!/bin/bash

modes='primary
secondary
mirror
duplicate
extend'
selected=`echo "$modes" | rofi -dmenu -i -no-show-icons -width 1000`

case $selected in
"primary")
mons -o
~/.config/bspwm/monitors -1
;;
"secondary")
mons -s
~/.config/bspwm/monitors -1
;;
"mirror")
mons -m
~/.config/bspwm/monitors -1
;;
"duplicate")
mons -d
~/.config/bspwm/monitors -1
;;
"extend")
mons -e right
~/.config/bspwm/monitors
;;
*)
;;
esac

#~/.config/bspwm/monitors &

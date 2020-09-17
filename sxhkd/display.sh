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
~/.config/bspwm/monitors
;;
"secondary")
mons -s
~/.config/bspwm/monitors
;;
"mirror")
mons -m
~/.config/bspwm/monitors
;;
"duplicate")
mons -d
~/.config/bspwm/monitors
;;
"extend")
mons -e right
~/.config/bspwm/monitors
;;
*)
;;
esac

~/.config/bspwm/monitors &

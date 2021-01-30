#!/bin/bash

i3lock \
    --show-failed-attempts \
    --pass-media-keys \
    --pass-volume-keys \
    --image="/home/mfr/.wallpaper/lock.png" \
    \
    --color=3d3d3dff \
    --verifcolor=00000000 \
    --keyhlcolor=000000ff \
    --ringcolor=3d3d3dff \
    --ringvercolor=3d3d3dff \
    --ringwrongcolor=e59d17ff \
    --insidecolor=00000000 \
    --insidevercolor=3d3d3d88 \
    --insidewrongcolor=00000000 \
    --timecolor=ffffffdd \
    --datecolor=00000000 \
    \
    --force-clock \
    --timestr="%H:%M" \
    --timesize=125 \
    --time-font="IBM Plex Sans Cond:style=Bold" \
    --timepos="x+w*0,1:h*0,2" \
    --time-align=1

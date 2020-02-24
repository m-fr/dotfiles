#!/bin/sh

# invoke global X session script
. /etc/X11/Xsession

# turn off bell
xset -b

# merge resource file
xrdb -merge ~/.Xresources

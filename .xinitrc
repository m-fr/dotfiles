#!/bin/sh

# invoke global X session script
. /etc/X11/Xsession

# merge resource file
xrdb -merge ~/.Xresources

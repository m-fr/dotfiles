#!/bin/bash
CMD="ln"
FLAGS="-sT"
MKDIR="mkdir -p"

profile=".xsessionrc .profile .env .vimrc .Xresources"
config="bspwm sxhkd rofi wtf polybar .shortcuts"
BIN="bin"

APTINSTALL=
APT="bash-completion bspwm sxhkd picom rofi dunst keepass2 polybar wget2 tree htop neofetch fonts-firacode ufw feh texlive-full scrot"

while getopts ":lmtfh" opt; do
    case ${opt} in
        l)
            CMD="ln"
            FLAGS="-sT"
            ;;
        m)
            CMD="cp"
            FLAGS="-r"
            ;;
        t)
            CMD="printf"
            FLAGS='\t%s -> %s\n'
            MKDIR="echo creating"
            ;;
        f)
            FLAGS="${FLAGS}f"
            ;;
        a)
            APTINSTALL=1
            ;;
        h)
            echo "Usage:"
            echo "  $0 [flags]"
            echo "      -l  use symbolic links (default)"
            echo "      -m  copy files instead of linking"
            echo "      -t  test installation"
            echo "      -f  force installation"
            echo "      -a  install apt packages"
            echo "      -h  show this help"
            exit 0
            ;;
        \?)
            echo "Invalid option: $OPTARG"
            echo "Try $0 -h"
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

if [[ $APTINSTALL ]]; then
    echo "Installing apt packages."
    sudo apt update && sudo apt install $APT
fi

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFDIR="$HOME/.config"
BINDIR="$HOME/.local/bin"

echo "Installing environment files to $HOME"
for item in $profile
do
    $CMD "$FLAGS" "$BASEDIR/$item" "$HOME/$item"
done

echo "Installing config files to $CONFDIR"
[[ -d $CONFDIR  ]] || $MKDIR "$CONFDIR"
for item in $config
do
    $CMD "$FLAGS" "$BASEDIR/$item" "$CONFDIR/$item"
done

echo "Installing executables to $BINDIR"
[[ -d $BINDIR  ]] || $MKDIR "$BINDIR"
for item in $(ls "$BASEDIR/$BIN")
do
    $CMD "$FLAGS" "$BASEDIR/$BIN/$item" "$BINDIR/$item"
done

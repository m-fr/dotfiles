#!/bin/bash
CMD="ln"
FLAGS="-sT"

profile=".profile .vimrc .Xresources"
config="bspwm sxhkd rofi wtf .shortcuts"
BIN="bin"

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
            ;;
        f)
            FLAGS="${FLAGS}f"
            ;;
        h)
            echo "Usage:"
            echo "  $0 [flags]"
            echo "      -l  use symbolic links (default)"
            echo "      -m  copy files instead of linking"
            echo "      -t  test instalation"
            echo "      -f  force instalation"
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

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFDIR="$HOME/.config"
BINDIR="$HOME/.local/bin"

echo "Installing environment files to $HOME"
for item in $profile
do
    $CMD "$FLAGS" "$BASEDIR/$item" "$HOME/$item"
done

echo "Installing config files to $CONFDIR"
for item in $config
do
    $CMD "$FLAGS" "$BASEDIR/$item" "$CONFDIR/$item"
done

echo "Installing executables to $BINDIR"
for item in $(ls $BASEDIR/$BIN)
do
    $CMD "$FLAGS" "$BASEDIR/$item" "$BINDIR/$item"
done

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

PATH="$PATH:/usr/local/texlive/2019/bin/i386-linux"
PATH="$PATH:/usr/local/go/bin/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

xset -b
xsetroot -cursor_name trek
xrdb -merge ~/.Xresources

mons -a -x ~/.local/bin/display-switcher &

~/.dropbox-dist/dropboxd &
birdtray &

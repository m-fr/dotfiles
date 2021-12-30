state=$(eww state)

if [[ "$state" == "" ]]; then
    eww open dashboard
else
    eww close dashboard
fi

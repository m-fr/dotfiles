LAYOUT=$(setxkbmap -query|awk -F : 'NR==3{sub(/^[ \t]+/, "", $2);print $2}')

case "$LAYOUT" in
	"us")
		setxkbmap cz
		;;
	"cz")
		setxkbmap fi
		;;
	*)
		setxkbmap us
		;;
esac

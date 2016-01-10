DEFAULT_SESSION="awesome"

xset r rate 250 40 &
xsetroot -cursor_name gentoo-silver
xmodmap ~/.Xmodmap
source ~/.fehbg

if [ "$HOST" -eq "nop" ]; then
	xscreensaver &
fi

case $1 in
	openbox)
		exec openbox-session
		;;
	awesome)
		exec awesome
		;;
	dwm)
		exec dwm
		;;
	*)
		exec $DEFAULT_SESSION
		;;
esac

DEFAULT_SESSION="awesome"

source ~/.fehbg
xset r rate 250 40
xsetroot -cursor_name gentoo-silver
xmodmap ~/.Xmodmap

if [ -x /usr/bin/xscreensaver ]; then
	xscreensaver &
	[ -x /usr/bin/xplanetFX ] && xplanetFX &>/dev/null &
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

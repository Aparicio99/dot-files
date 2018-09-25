DEFAULT_SESSION="awesome"

[ -f ~/.fehbg ] && source ~/.fehbg
type nm-applet && nm-applet &
xset r rate 250 40
xsetroot -cursor_name gentoo-silver
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

if type xscreensaver; then
	xscreensaver -no-splash &
	type xplanetFX && xplanetFX &
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

DEFAULT_SESSION="awesome"

xset r rate 250 40 &
xsetroot -cursor_name gentoo-silver
xmodmap /home/aparicio/.Xmodmap

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

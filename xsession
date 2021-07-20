#!/bin/sh
DEFAULT_SESSION="awesome"

[ -f ~/.fehbg ] && source ~/.fehbg
type nm-applet && nm-applet &
xset r rate 250 40
xsetroot -cursor_name gentoo-silver
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

if type xscreensaver; then
	xscreensaver -no-splash &
	#type xplanetFX && xplanetFX &
fi

exec dbus-launch --exit-with-session awesome

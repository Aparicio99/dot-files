#!/bin/sh

[ -f ~/.fehbg ] && source ~/.fehbg
type nm-applet && nm-applet &
xset r rate 250 40
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

if type xscreensaver; then
	xscreensaver -no-splash &
	#type xplanetFX && xplanetFX &
fi

if type gentoo-pipewire-launcher; then
	gentoo-pipewire-launcher restart &
fi

if grep ubuntu /etc/os-release >/dev/null; then
	exec awesome
#else
#	exec dbus-launch --exit-with-session awesome
fi

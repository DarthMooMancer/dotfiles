#!/usr/bin/env bash
while true; do
	xwallpaper --zoom "$(find /home/andrew/.config/suckless/dwm/bgs -type f | shuf -n1)"
	sleep 600  # Pause for 10 minutes - default 600 seconds
done

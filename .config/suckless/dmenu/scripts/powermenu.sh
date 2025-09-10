#!/usr/bin/env bash

output=$(echo -e "Poweroff\nReboot\nQuit Dwm" | dmenu -p "Power Actions: " -l 3) 
if [ $output == "Poweroff" ]; then
	st -e sh -c "doas poweroff"
else if [ $output == "Reboot"]; then
	st -e sh -c "doas reboot"
else if [ $output == "Quit Dwm"]; then
	st -e sh -c "pkill X"
fi

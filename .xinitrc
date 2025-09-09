gentoo-pipewire-launcher &
xinput set-prop "Logitech USB Receiver Mouse" "libinput Accel Speed" -0.4 &
sh /home/andrew/.config/suckless/dwm/scripts/sflwal.sh &
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144 &
dunst &
picom -b &
while true; do
	dwm 2>.dwm.log
done

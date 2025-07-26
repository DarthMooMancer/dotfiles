gentoo-pipewire-launcher &
eval "$(dbus-launch --sh-syntax --exit-with-session)" &
xinput set-prop "Logitech USB Receiver Mouse" "libinput Accel Speed" -0.4 &
sh /home/andrew/.config/suckless/dwm/scripts/shuffle_wallpapers.sh &
st -e bash -c 'cd /home/andrew/Minecraft_Server/ && /home/andrew/Minecraft_Server/start.sh' &
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144 &
while true; do
    pkill slstatus
    slstatus &
    dwm 2>~/.dwm.log
done

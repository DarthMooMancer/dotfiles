#!/bin/sh
last=$(cat /tmp/last_wallpaper_time)

now=$(date +%s)
remaining=$((600 - (now - last)))

[ "$remaining" -lt 0 ] && remaining=0
    
min=$((remaining / 60))
sec=$((remaining % 60))

# Format as mm:ss
printf "%02d:%02d\n" "$min" "$sec"

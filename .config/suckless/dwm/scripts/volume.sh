#!/usr/bin/env bash

if [ "$1" == "up" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ +2%
elif [ "$1" == "down" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -2%
fi

TEST=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%", $2 * 100}')
dunstify -t 2000 "Volume: ${TEST}" -h int:value:${TEST%%%} -h string:synchronous:volume

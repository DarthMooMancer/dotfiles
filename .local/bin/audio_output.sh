#!/usr/bin/env bash

# Changes the audio output device with dmenu
SPEAKER="Speaker"
HEADPHONES="Headphones"

OUTPUT="$(echo -e "${SPEAKER}\n${HEADPHONES}" | dmenu -l 2)"

if [[ ${OUTPUT} == ${SPEAKER} ]]; then
	wpctl set-default 52
elif [[ ${OUTPUT} == ${HEADPHONES} ]]; then
	wpctl set-default 53
fi

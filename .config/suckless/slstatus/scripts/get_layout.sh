#!/bin/bash

variant=$(setxkbmap -query | awk '/variant:/ { print $2 }')

if [[ "$variant" == "colemak_dh" ]]; then
	echo "CLMK"
else
	echo "QWRT"
fi


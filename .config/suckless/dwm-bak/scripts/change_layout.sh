#!/bin/bash

variant=$(setxkbmap -query | awk '/variant:/ { print $2 }')

if [[ "$variant" == "colemak_dh" ]]; then
  setxkbmap us
  layout="qwe"
else
  setxkbmap us -variant colemak_dh
  layout="cdh"
fi

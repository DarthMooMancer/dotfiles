#!/usr/bin/env bash

q=$(echo -e "Add\nSubtract\nMultiply\nDivide" | dmenu -l 4 -p "Options: ")
f=$(dmenu -p "First: " < /dev/null)
s=$(dmenu -p "Second: " < /dev/null)
r=""

case "$q" in
    Add)      r=$((f + s)) ;;
    Subtract) r=$((f - s)) ;;
    Multiply) r=$((f * s)) ;;
    Divide)   r=$(echo "scale=2; $f / $s" | bc) ;;
esac

echo "$r" | dmenu -p "Answer: "

# #!/usr/bin/env bash
#
# INTERVAL=600  # 10 minutes
#
# if [[ -f /tmp/last_wallpaper_time ]]; then
#     last=$(cat /tmp/last_wallpaper_time)
# else
#     last=$(date +%s)
# fi
#
# now=$(date +%s)
# elapsed=$(( now - last ))
# remaining=$(( INTERVAL - elapsed ))
#
# if (( remaining < 0 )); then
#     remaining=0
# fi
#
# # Format as mm:ss
# printf "%02d:%02d" $((remaining / 60)) $((remaining % 60))
#
#!/bin/sh

INTERVAL=600  # 10 minutes

if [ -f /tmp/last_wallpaper_time ]; then
    last=$(cat /tmp/last_wallpaper_time)
else
    last=$(date +%s)
fi

now=$(date +%s)
elapsed=$((now - last))
remaining=$((INTERVAL - elapsed))

if [ "$remaining" -lt 0 ]; then
    remaining=0
fi

min=$((remaining / 60))
sec=$((remaining % 60))

# Format as mm:ss
printf "%02d:%02d\n" "$min" "$sec"


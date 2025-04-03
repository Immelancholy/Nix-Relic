#!/usr/bin/env sh
# Check swww daemon
wall="$HOME/Pictures/wallpapers/Neon-Beast-Girl.png"
swww query
if [ $? -eq 1 ]; then
	swww-daemon
fi
sleep 1
swww img $wall &

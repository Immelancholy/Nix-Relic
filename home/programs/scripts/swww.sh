#!/usr/bin/env sh
# Check swww daemon
wall="$HOME/Pictures/wallpapers/anime-girl-wings.jpg"
swww query
if [ $? -eq 1 ]; then
	swww-daemon
fi
sleep 1
swww img $wall &

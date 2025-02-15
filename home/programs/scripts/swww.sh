#!/usr/bin/env sh
# Check swww daemon
swww query
if [ $? -eq 1 ]; then
	swww-daemon
fi
sleep 1
swww img /home/mela/Pictures/wallpapers/anime-girl-wings.jpg &

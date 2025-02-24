#!/usr/bin/env sh

# Toggle kitty padding when starting/quitting a vim instance
kitty @ set-spacing padding=0
neo -a -S 20 -d 1 -f 144 -D -C /home/mela/.local/share/bin/colors -b 1 -m "Welcome, $USER." --lingerms=1,1 --rippct=0 "$@"
kitty @ set-spacing padding=default

#!/usr/bin/env sh

# Toggle kitty padding when starting/quitting a vim instance
kitty @ set-spacing padding=0
kitty @ set-font-size 3 
cava "$@"
kitty @ set-spacing padding=default
kitty @ set-font-size 10 

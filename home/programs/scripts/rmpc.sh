#!/usr/bin/env sh

# Toggle kitty padding when starting/quitting a vim instance
kitty @ set-spacing padding=2
kitty @ set-font-size 9
kitty @ set-font "JetBrainsMono Nerd Font Mono"
rmpc "$@"
kitty @ set-spacing padding=default
kitty @ set-font-size 10 
kitty @ set-font default

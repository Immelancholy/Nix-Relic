#!/usr/bin/env sh

# Toggle kitty padding when starting/quitting a vim instance
kitty @ set-spacing padding=0
tmux "$@"
kitty @ set-spacing padding=default

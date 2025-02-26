#!/usr/bin/env sh

kitty @ set-spacing padding=5
kitty @ set-font-size 9.5
btop "$@"
kitty @ set-spacing padding=default
kitty @ set-font-size 10

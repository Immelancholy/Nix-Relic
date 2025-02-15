#!/usr/bin/env sh

# Toggle kitty padding when starting/quitting a vim instance
kitty @ set-spacing padding=10
yazi "$@"
kitty @ set-spacing padding=default

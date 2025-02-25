#!/usr/bin/env bash

i=0
sesh=${"dev+$i"}

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -s $sesh -d 'nv.sh; $SHELL'
tmux split-window -h
tmux neww 'lazygit; $SHELL'
tmux attach-session -t $sesh




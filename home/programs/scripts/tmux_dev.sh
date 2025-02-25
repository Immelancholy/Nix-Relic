#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 'nv.sh; $SHELL' 

tmux new-window 'lazygit; $SHELL'

tmux previous-window

tmux split-window -v

tmux attach-session -t $sesh

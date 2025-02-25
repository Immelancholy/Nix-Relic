#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 'nv; $SHELL'

tmux split-window -v 'lazygit; $SHELL'

tmux attach-session -t $sesh

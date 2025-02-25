#!/usr/bin/env bash

i=0
sesh="dev"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
	sesh="dev$i"
done
tmux new -d -s $sesh 'nv.sh; $SHELL' 

tmux new-window 'lazygit; $SHELL' 

tmux split-window -v

tmux select-pane -t 0

tmux resize-pane -D 60

tmux select-window -t ^ 

tmux attach-session -t $sesh


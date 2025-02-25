#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 'nv.sh; $SHELL' 

tmux new-window 'lazygit; $SHELL' 

tmux split-window -v

tmux resize-pane -t 0 -D 60

tmux select-pane -t 0

tmux previous-window

tmux attach-session -t $sesh


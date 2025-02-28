#!/usr/bin/env bash

i=0
sesh="pulsemixer"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
	sesh="dev$i"
done
tmux new -d -s $sesh "pulsemixer; $SHELL" 

tmux split-window -v

tmux select-pane -t 0

tmux resize-pane -D 60

tmux attach-session -t $sesh


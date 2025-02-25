#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 

tmux new-window 

tmux previous-window

tmux split-window -v

tmux attach-session -t $sesh

tmux send-keys -t 0 'nv' C-m

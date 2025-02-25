#!/usr/bin/env bash

i=0
sesh=${"dev$i"}

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new-session -d -s $sesh

tmux split-window -h

tmux send-keys -t 0 'nv.sh' C-m



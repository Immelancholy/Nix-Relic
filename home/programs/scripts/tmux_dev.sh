#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 

tmux new-window 

tmux split-window -v

send-keys -t 1 'lazygit' C-m

tmux previous-window

tmux send-keys -t 0 'nv.sh' C-m

tmux attach-session -t $sesh


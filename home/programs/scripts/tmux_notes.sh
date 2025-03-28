#!/usr/bin/env bash

i=0
sesh="dev"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
	sesh="dev$i"
done
tmux new -d -s $sesh -c "$HOME/obsidian/" "nv.sh; $SHELL"

tmux new-window -c "$HOME/obsidian/" 

tmux select-window -t ^ 

tmux attach-session -t $sesh


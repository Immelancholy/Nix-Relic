#!/usr/bin/env bash

i=0
sesh="Notes"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
	sesh="Notes$i"
done
tmux new -d -s $sesh -c "$HOME/obsidian/"

tmux new-window -c "$HOME/obsidian/" 

tmux select-window -t ^ 

tmux send-keys "nv.sh" C-m

tmux attach-session -t $sesh


#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 'nv.sh; $SHELL'

tmux split-window -v

tmux selec-layout main-horizontal maine-pane-height 316

tmux new-window lazygit

tmux attach-session -t $sesh

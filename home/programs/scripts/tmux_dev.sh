#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh -n "NeoVim" 'nv.sh; $SHELL' 

tmux split-window -v 

tmux new-window  -n "LazyGit" 'lazygit; $SHELL'

tmux previous-window

tmux attach-session -t $sesh

#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh -n "NeoVim" 'nv.sh; $SHELL' 

tmux split-window -v 

tmux resize-pane -D -t 2 -t "NeoVim"

tmux new-window lazygit -T -n "LazyGit"

tmux previous-window

tmux attach-session -t $sesh

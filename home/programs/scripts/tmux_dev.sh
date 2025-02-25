#!/usr/bin/env bash

i=0
sesh="dev$i"

# Check if the session already exists
while tmux has-session -t $sesh 2>/dev/null; do
	((i++))
done
tmux new -d -s $sesh 'nv.sh; $SHELL' -t "Neovim"

tmux split-window -v -t "zsh"

tmux resize-pane -D -t "zsh" 2

tmux new-window lazygit -T "LazyGit"

tmux previous-window

tmux attach-session -t $sesh

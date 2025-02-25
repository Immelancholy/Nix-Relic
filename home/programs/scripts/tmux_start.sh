#!/usr/bin/env bash

i=0

# Check if the session already exists
while tmux has-session -t $i 2>/dev/null; do
	((i++))
done
tmux new -s $i 'poke.sh; $SHELL'


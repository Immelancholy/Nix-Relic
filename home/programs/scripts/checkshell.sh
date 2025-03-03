#!/usr/bin/env bash 
shell=$($SHELL --version | cut -d ' ' -f 1)
shell=${shell^}
echo "$shell"

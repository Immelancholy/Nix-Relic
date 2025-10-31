{writeShellScriptBin, ...}:
writeShellScriptBin "tnote" ''
  sesh="Notes"

  if tmux has-session -t $sesh 2>/dev/null; then
    printf '%s' "$sesh already exists. Attatching to session $sesh."
    tmux attach-session -t $sesh
  else
    tmux new -d -s $sesh -c "$NOTES_PATH"

    tmux new-window -c "$NOTES_PATH"

    tmux select-window -t ^

    tmux send-keys "nvim" C-m

    tmux attach-session -t $sesh
  fi
''

{writeShellScriptBin, ...}:
writeShellScriptBin "tnix" ''
  sesh="NixDots"

  if tmux has-session -t $sesh 2>/dev/null; then
    printf '%s' "$sesh already exists. Attatching to session $sesh."
    tmux attach-session -t $sesh
  else
    tmux new -d -s $sesh -c "$FLAKE_PATH"

    tmux new-window -c "$FLAKE_PATH"

    tmux select-window -t ^

    tmux send-keys "nvim" C-m

    tmux attach-session -t $sesh
  fi
''

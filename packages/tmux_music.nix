{writeShellScriptBin, ...}:
writeShellScriptBin "tmusic" ''
  sesh="Music"

  if tmux has-session -t $sesh 2>/dev/null; then
    printf '%s' "$sesh already exists. Attatching to session $sesh."
    tmux attach-session -t $sesh
  else
    tmux new -d -s "$sesh" "inori"

    tmux set status off

    tmux splitw -h -p 60 "artis" "$@"

    tmux select-pane -t 1

    tmux attach-session -t "$sesh"
  fi
''

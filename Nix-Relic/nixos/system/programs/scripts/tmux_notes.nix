{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "tnote" ''
      i=0
      sesh="Notes"

      # Check if the session already exists
      while tmux has-session -t $sesh 2>/dev/null; do
        ((i++))
        sesh="$sesh$i"
      done
      tmux new -d -s $sesh -c "$NOTES_PATH"

      tmux new-window -c "$NOTES_PATH"

      tmux select-window -t ^

      tmux send-keys "y" C-m

      tmux attach-session -t $sesh
    '')
  ];
}

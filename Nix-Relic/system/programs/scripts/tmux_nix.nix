{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "tnix" ''
      i=0
      sesh="NixDots"

      # Check if the session already exists
      while tmux has-session -t $sesh 2>/dev/null; do
        ((i++))
        sesh="$sesh$i"
      done
      tmux new -d -s $sesh -c "$FLAKE_PATH"

      tmux new-window -c "$FLAKE_PATH"

      tmux select-window -t ^

      tmux send-keys "y" C-m

      tmux attach-session -t $sesh
    '')
  ];
}

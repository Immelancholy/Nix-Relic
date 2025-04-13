{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "tdev" ''
      i=0
      sesh="DevSesh"

      # Check if the session already exists
      while tmux has-session -t $sesh 2>/dev/null; do
        ((i++))
        sesh="DevSesh$i"
      done
      tmux new -d -s $sesh -c "$PROJECTS_PATH"

      tmux new-window -c "$PROJECTS_PATH"

      tmux select-window -t ^

      tmux send-keys "y" C-m

      tmux attach-session -t $sesh
    '')
  ];
}

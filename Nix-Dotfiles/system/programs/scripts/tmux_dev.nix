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
      tmux new -d -s $sesh

      tmux new-window

      tmux select-window -t ^

      tmux send-keys "nv" C-m

      tmux attach-session -t $sesh
    '')
  ];
}

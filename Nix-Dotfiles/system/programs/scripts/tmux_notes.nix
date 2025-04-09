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
      tmux new -d -s $sesh -c "$HOME/Documents/Obsidian Vault/"

      tmux new-window -c "$HOME/Documents/Obsidian Vault/"

      tmux select-window -t ^

      tmux send-keys "nv" C-m

      tmux attach-session -t $sesh
    '')
  ];
}

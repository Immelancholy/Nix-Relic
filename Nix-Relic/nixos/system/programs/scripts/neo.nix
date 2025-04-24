{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "neo.sh" ''
      kitty @ set-spacing padding=2
      neo -a -S 20 -d 1 -f 144 -C "$XDG_CONFIG_HOME"/neo/colors -b 1 -m "Welcome, ''${USER^}." --lingerms=1,1 --rippct=0 "$@"
      kitty @ set-spacing padding=default
    '')
  ];
}

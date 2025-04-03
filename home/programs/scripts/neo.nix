{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "neo.sh" ''
      kitty @ set-spacing padding=0
      neo -a -S 20 -d 1 -f 144 -C "$XDG_CONFIG_HOME"/neo/colors -b 1 -m "Welcome, ''${USER^}." --lingerms=1,1 --rippct=0 "$@"
      kitty @ set-spacing padding=default
    '')
  ];
  xdg.configFile."/neo/colors".text = ''
    neo_color_version 1
    -1
    177
    141
    183
    153
    224
    225
  '';
}

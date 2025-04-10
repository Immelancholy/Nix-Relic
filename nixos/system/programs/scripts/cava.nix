{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "cava.sh" ''
      kitty @ set-spacing padding=0
      kitty @ set-font-size 3
      cava "$@"
      kitty @ set-spacing padding=default
      kitty @ set-font-size 10
    '')
  ];
}

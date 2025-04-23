{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "rmpc.sh" ''
      kitty @ set-spacing padding=2
      kitty @ set-font-size 9.5
      rmpc "$@"
      kitty @ set-spacing padding=default
      kitty @ set-font-size 10
    '')
  ];
}

{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "pipes" ''
      kitty @ set-spacing padding=2
      pipes.sh -p 12 -t 1 -r 0 "$@"
      kitty @ set-spacing padding=default
    '')
  ];
}

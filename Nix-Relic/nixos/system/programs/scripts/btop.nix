{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "btop.sh" ''
      kitty @ set-font-size 9.5
      btop "$@"
      kitty @ set-font-size 10
    '')
  ];
}

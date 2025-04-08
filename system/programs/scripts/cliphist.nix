{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "cliphist.sh" ''
      cliphist list | rofi -dmenu | cliphist decode | wl-copy
    '')
  ];
}

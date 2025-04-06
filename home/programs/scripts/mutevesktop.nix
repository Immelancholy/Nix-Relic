{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "pushToMuteVesktop" ''
      input=$(wpctl status | grep "Chromium input" | grep -v "mela@nixos" | grep -o -E '[0-9]+')
      wpctl set-mute "$input" toggle
    '')
  ];
}

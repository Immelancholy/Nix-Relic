{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "pushToMuteChromium" ''
      mapfile -t inputs < <(wpctl status | grep "Chromium input" | grep -v "mela@nixos" | grep -o -E '[0-9]+')
      for i in "''${inputs[@]}"
        wpctl set-mute "$i" toggle
    '')
  ];
}

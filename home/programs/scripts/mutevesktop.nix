{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "pushToMuteVesktop" ''
      input=$(wpctl status | grep "Chromium input" | grep -v "mela@nixos" | grep -o -E '[0-9]+')
      if [ "$mute" = 1 ]; then
        wpctl set-mute "$input" 0
        mute=""
      else
        mute=1
        wpctl set-mute "$input" 1
      fi
    '')
  ];
}

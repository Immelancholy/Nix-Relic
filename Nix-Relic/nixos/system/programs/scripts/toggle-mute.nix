{pkgs, ...}: let
  toggle-mute = pkgs.writeShellScriptBin "toggle-mute" ''
    MUTED=$(wpctl get-volume @DEFAULT_SOURCE@)
    MUTED=''${MUTED:13}
    COMMES=$(wpctl status | grep "commes_mic_out" | awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")

    case $1 in
      --unmute-all)
        wpctl set-mute @DEFAULT_SOURCE@ 0
        wpctl set-mute "$COMMES" 0
        exit 0
        ;;
    esac

    function mute () {
      if [ "$MUTED" = "[MUTED]" ]; then
        wpctl set-mute @DEFAULT_SOURCE@ 0
        wpctl set-mute "$COMMES" 1
      else
        wpctl set-mute @DEFAULT_SOURCE@ 1
        wpctl set-mute "$COMMES" 0
      fi
    }

    mute
  '';
in {
  environment.systemPackages = [
    toggle-mute
  ];
}

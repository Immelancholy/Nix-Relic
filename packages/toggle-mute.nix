{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "toggle-mute";
  runtimeInputs = [
    pkgs.wireplumber
    pkgs.gawk
  ];
  text = ''

    MUTED=$(wpctl get-volume @DEFAULT_SOURCE@)
    MUTED=''${MUTED:13}
    COMMES=$(wpctl status | grep "commes_mic_out" | awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")

    show_help () {
      printf "%s" "\
        useage: toggle-mute [-h|--help] [--unmute-all]

        optional arguments:
        -h, --help                Show this help message and exit
        --unmute-all              Unmute audio sources
      "
    }

    mute () {
      if [ "$MUTED" = "[MUTED]" ]; then
        wpctl set-mute @DEFAULT_SOURCE@ 0
        wpctl set-mute "$COMMES" 1
      else
        wpctl set-mute @DEFAULT_SOURCE@ 1
        wpctl set-mute "$COMMES" 0
      fi
    }

    options=$(getopt -o h --long 'unmute-all,help' -- "$@")
    eval set -- "$options"

    case "$1" in
      -h|--help)
        show_help
        exit
        ;;
      --unmute-all)
        shift;
        wpctl set-mute @DEFAULT_SOURCE@ 0
        wpctl set-mute "$COMMES" 0
        exit
        ;;
      --)
        shift
        ;;
    esac

    mute
  '';
}

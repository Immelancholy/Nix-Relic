{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "playerVol";
  runtimeInputs = [
    pkgs.gawk
    pkgs.bc
    pkgs.wireplumber
  ];
  text = ''
    notify_volume () {
      VOL_WPCTL=$(wpctl get-volume @DEFAULT_SINK@)
      VOL=''${VOL_WPCTL:8}
      VOLUME_PERCENT=$(bc <<< " ''${VOL} * 100 ")
      VOLUME_PERCENT=''${VOLUME_PERCENT%.*}
      MUTED=''${VOL_WPCTL:13}
      if [ "$MUTED" = "[MUTED]" ]; then
        VOLUME_PERCENT=0
      fi

      dunstctl close-all
      dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME_PERCENT" "$VOLUME_PERCENT""%"
    }

    if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute") ]]; then
        printf "Usage: %s [inc|dec|mute]\n" "$0" >&2
        exit 1
    fi

    # Check if wpctl is available
    if ! command -v wpctl &> /dev/null; then
      echo "Error: wireplumber is not installed. Please install it." >&2
      exit 1
    fi

    if [[ "$1" == "inc" ]]; then
      wpctl set-volume @DEFAULT_SINK@ 5%+
      notify_volume
    elif [[ "$1" == "dec" ]]; then
      wpctl set-volume @DEFAULT_SINK@ 5%-
      notify_volume
    elif [[ "$1" == "mute" ]]; then
      wpctl set-mute @DEFAULT_SINK@ toggle
      notify_volume
    fi

  '';
}

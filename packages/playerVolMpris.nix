{
  writeShellApplication,
  pkgs,
  player ? "mpd",
  ...
}:
writeShellApplication {
  name = "playerVol";

  runtimeInputs = [
    pkgs.bc
    pkgs.playerctl
  ];

  text = ''
    function notify_volume() {
      # Function to show volume notification
      VOLUME=$(playerctl --player=${player} volume)
      VOLUME_MAX=1
      VOLUME_PERCENT=$(bc <<< "scale=2; ''${VOLUME} / ''${VOLUME_MAX} * 100")
      VOLUME_PERCENT=''${VOLUME_PERCENT%.*}

      dunstctl close-all
      dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME_PERCENT" "$VOLUME_PERCENT""%"
    }

    function mute () {
      vol=$(playerctl --player=${player} volume)
      if [ -f "$XDG_RUNTIME_DIR"/old_vol ]; then
        old_vol=$(<"$XDG_RUNTIME_DIR"/old_vol)
      else
        touch "$XDG_RUNTIME_DIR"/old_vol
      fi
      if (( $(bc -l <<< "''${vol} > 0") )); then
        playerctl --player=${player} volume 0 > /dev/null
        echo "$vol" > "$XDG_RUNTIME_DIR"/old_vol
      elif [ "$old_vol" != "" ]; then
        playerctl --player=${player} volume "$old_vol" > /dev/null
      else
        playerctl --player=${player} volume 1 > /dev/null
      fi
    }


    if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute") ]]; then
        printf "Usage: %s [inc|dec|mute]\n" "$0" >&2
        exit 1
    fi

    # Check if playerctl is available
    if ! command -v playerctl &> /dev/null; then
      echo "Error: playerctl is not installed. Please install it." >&2
      exit 1
    fi

    if [[ "$1" == "inc" ]]; then
      playerctl --player=${player} volume 0.1+ > /dev/null
      notify_volume
    elif [[ "$1" == "dec" ]]; then
      playerctl --player=${player} volume 0.1- > /dev/null
      notify_volume
    elif [[ "$1" == "mute" ]]; then
      mute
      notify_volume
    fi
  '';
}

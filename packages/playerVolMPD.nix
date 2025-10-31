{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "playerVol";
  runtimeInputs = [
    pkgs.mpc
    pkgs.dunst
  ];
  text = ''
    function notify_volume() {
      # Function to show volume notification
      VOLUME=$(mpc volume | sed 's/.*://')

      dunstctl close-all
      dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME" "$VOLUME"
    }

    function mute () {
      vol=$(mpc volume | sed 's/.*://')
      vol_int="''${vol//"%"}"
      if [ -f "$XDG_RUNTIME_DIR"/old_vol ]; then
        old_vol=$(<"$XDG_RUNTIME_DIR"/old_vol)
      else
        touch "$XDG_RUNTIME_DIR"/old_vol
      fi
      if [ "$vol_int" -gt 0 ]; then
        mpc volume 0 > /dev/null
        echo "$vol_int" > "$XDG_RUNTIME_DIR"/old_vol
      elif [ "$old_vol" != "" ]; then
        mpc volume "$old_vol" > /dev/null
      else
        mpc volume 100 > /dev/null
      fi
    }


    if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute") ]]; then
        printf "Usage: %s [inc|dec|mute]\n" "$0" >&2
        exit 1
    fi

    # Check if mpc is available
    if ! command -v mpc &> /dev/null; then
      echo "Error: mpc is not installed. Please install it." >&2
      exit 1
    fi

    if [[ "$1" == "inc" ]]; then
      mpc volume +1 > /dev/null
      notify_volume
    elif [[ "$1" == "dec" ]]; then
      mpc volume -1 > /dev/null
      notify_volume
    elif [[ "$1" == "mute" ]]; then
      mute
      notify_volume
    fi

  '';
}

{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "volumeControl" ''

      function notify_volume() {
        # Function to show brightness notification
        VOLUME=$(mpc volume | sed 's/.*://')
        VOLUME_PERCENT="''${VOLUME%f}"

        dunstctl close-all
        dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME_PERCENT" "$VOLUME_PERCENT""%"
      }


      if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec") ]]; then
          printf "Usage: %s [inc|dec]\n" "$0" >&2
          exit 1
      fi

      # Check if brightnessctl is available
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
      fi
    '')
  ];
}

{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  player = config.player.name;
  musicdae = pkgs.writeShellScriptBin "playerVol" ''
    function notify_volume() {
      # Function to show brightness notification
      VOLUME=$(mpc volume | sed 's/.*://')

      dunstctl close-all
      dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME" "$VOLUME"
    }

    function mute () {
      vol=$(mpc volume | sed 's/.*://')
      vol_int="''${vol//"%"}"
      old_vol=$(</tmp/old_vol)
      if [ "$vol_int" -gt 0 ]; then
        mpc volume 0 > /dev/null
        echo "$vol_int" > /tmp/old_vol
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

    # Check if brightnessctl is available
    if ! command -v playerctl &> /dev/null; then
      echo "Error: mpris is not installed. Please install it." >&2
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
  other = pkgs.writeShellScriptBin "playerVol" ''
    function notify_volume() {
      # Function to show brightness notification
      VOLUME=$(playerctl --player=${player} volume)
      VOLUME_MAX=1
      VOLUME_PERCENT=$(${pkgs.bc}/bin/bc <<< "scale=2; "$VOLUME" / "$VOLUME_MAX" * 100")
      VOLUME_PERCENT=''${VOLUME_PERCENT%.*}

      dunstctl close-all
      dunstify -t 3000 -a "  Volume" -h int:value:"$VOLUME_PERCENT" "$VOLUME_PERCENT""%"
    }

    function mute () {
      vol=$(playerctl --player=${player} volume)
      old_vol=$(</tmp/old_vol)
      if (( $(${pkgs.bc}/bin/bc -l <<< ""$vol" > 0") )); then
        playerctl --player=${player} volume 0 > /dev/null
        echo "$vol" > /tmp/old_vol
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

    # Check if brightnessctl is available
    if ! command -v mpc &> /dev/null; then
      echo "Error: mpc is not installed. Please install it." >&2
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
in {
  config = mkMerge [
    (mkIf (config.player.name == "mpd") {
      home.packages = [
        musicdae
      ];
    })
    (mkIf (config.player.name != "mpd") {
      home.packages = [
        other
      ];
    })
  ];
}

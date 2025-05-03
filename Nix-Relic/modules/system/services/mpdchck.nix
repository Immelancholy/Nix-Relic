{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.mpdchck;

  mpdchck = pkgs.writeShellScriptBin "mpdchck.sh" ''
    while :
    do
      state=$(mpc status %state%)
      if [ "$state" = "playing" ];
      then
        sr.sh > /dev/null
      fi
    done
  '';
  srsh = pkgs.writeShellScriptBin "sr.sh" ''
    pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
    mapfile -t allowedRates < <( pw-metadata -n settings | grep 'clock.allowed-rates' | cut -d "'" -f 4 | tr -d "[" | tr -d "]" | tr -d , )
    while :
    do
      state=$(mpc status %state%)
      if [ "$state" != "playing" ];
      then
        pw-metadata -n settings 0 clock.force-rate 0 > /dev/null

        break
      fi
      currentRate=$(mpc status %samplerate%)
      if [ "$currentRate" = "%samplerate%" ];
      then
        pw-metadata -n settings 0 clock.force-rate 0 > /dev/null

        break
      fi
      if [ "$currentRate" != "$pwrate" ];
      then
        if [[ " ''${allowedRates[*]}" =~ [[:space:]]''${currentRate}[[:space:]] ]];
        then
          pw-metadata -n settings 0 clock.force-rate "$currentRate" > /dev/null
          pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)

        elif [ $(( currentRate % 48000 )) -eq 0 ];
        then
          if [[ " ''${allowedRates[*]}" =~ [[:space:]]192000[[:space:]] ]];
          then
            pw-metadata -n settings 0 clock.force-rate 192000 > /dev/null
            pwrate=''${currentRate}

          elif [[ " ''${allowedRates[*]}" =~ [[:space:]]96000[[:space:]] ]];
          then
            pw-metadata -n settings 0 clock.force-rate 96000 > /dev/null
            pwrate=''${currentRate}

          elif [[ " ''${allowedRates[*]}" =~ [[:space:]]48000[[:space:]] ]];
          then
            pw-metadata -n settings 0 clock.force-rate 48000 > /dev/null
            pwrate=''${currentRate}

          else
            kill "$pid"
            pw-metadata -n settings 0 clock.force-rate 44100 > /dev/null
            pwrate=''${currentRate}

          fi

        else
          if [[ " ''${allowedRates[*]}" =~ [[:space:]]88200[[:space:]] ]];
          then
            pw-metadata -n settings 0 clock.force-rate 88200 > /dev/null
            pwrate=''${currentRate}

          else
            pw-metadata -n settings 0 clock.force-rate 44100 > /dev/null
            pwrate=''${currentRate}

          fi
        fi

      fi

    done
  '';
in {
  options.services.mpdchck = {
    enable = mkEnableOption "Enable mpdchck service";
    address = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Host address for mpd";
    };
    port = mkOption {
      type = types.port;
      default = 6600;
      description = "Port for mpd";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      mpdchck
      srsh
    ];
    systemd.user.services."mpdchck" = {
      enable = true;
      name = "mpdchck";
      after = ["mpd.service"];
      wantedBy = ["default.target"];
      path = [
        mpdchck
        srsh
        pkgs.pipewire
        pkgs.mpc
      ];
      script = ''mpdchck.sh'';
      serviceConfig = {
        Restart = "always";
      };
      environment = {
        MPD_HOST = cfg.address;
        MPD_PORT = builtins.toString cfg.port;
      };
    };
  };
}

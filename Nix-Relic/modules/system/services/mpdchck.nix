{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.services.mpdchck;
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
      (pkgs.writeShellScriptBin "mpdchck.sh" ''
        while :
        do
          state=$(mpc status %state%)
          if [ "$state" = "playing" ];
          then
            sr.sh
          fi
        done
      '')
      (pkgs.writeShellScriptBin "sr.sh" ''
        pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
        mapfile -t allowedRates < <( pw-metadata -n settings | grep 'clock.allowed-rates' | cut -d "'" -f 4 | tr -d "[" | tr -d "]" | tr -d , )
        while :
        do
          state=$(mpc status %state%)
          if [ "$state" = "paused" ] || [ "$state" = "stopped" ];
          then
            pw-metadata -n settings 0 clock.force-rate 0

            break
          fi
          currentRate=$(mpc status %samplerate%)

          if [ "$currentRate" != "$pwrate" ];
          then
            if [[ " ''${allowedRates[*]}" =~ [[:space:]]''${currentRate}[[:space:]] ]];
            then
              pw-metadata -n settings 0 clock.force-rate "$currentRate"
              pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)

            elif [ $(( currentRate % 48000 )) -eq 0 ];
            then
              if [[ " ''${allowedRates[*]}" =~ [[:space:]]192000[[:space:]] ]];
              then
                pw-metadata -n settings 0 clock.force-rate 192000
                pwrate=''${currentRate}

              elif [[ " ''${allowedRates[*]}" =~ [[:space:]]96000[[:space:]] ]];
              then
                pw-metadata -n settings 0 clock.force-rate 96000
                pwrate=''${currentRate}

              elif [[ " ''${allowedRates[*]}" =~ [[:space:]]48000[[:space:]] ]];
              then
                pw-metadata -n settings 0 clock.force-rate 48000
                pwrate=''${currentRate}

              else
                kill "$pid"
                pw-metadata -n settings 0 clock.force-rate 44100
                pwrate=''${currentRate}

              fi

            else
              if [[ " ''${allowedRates[*]}" =~ [[:space:]]88200[[:space:]] ]];
              then
                pw-metadata -n settings 0 clock.force-rate 88200
                pwrate=''${currentRate}

              else
                pw-metadata -n settings 0 clock.force-rate 44100
                pwrate=''${currentRate}

              fi
            fi

          fi

        done
      '')
    ];
    systemd.user.services."mpdchck" = {
      enable = true;
      name = "mpdchck";
      after = ["mpd.service"];
      wantedBy = ["default.target"];
      path = [
        "/run/current-system/sw"
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

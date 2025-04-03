{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "sr.sh" ''
      pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)
      mapfile -t allowedRates < <( pw-metadata -n settings | grep 'clock.allowed-rates' | cut -d "'" -f 4 | tr -d "[" | tr -d "]" | tr -d , )
      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "paused" ] || [ "$state" = "stopped" ];
        then
          pid=$(pgrep qpwgraph)
          kill "$pid"
          pw-metadata -n settings 0 clock.force-rate 0

          hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
          hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
          break
        fi
        currentRate=$(mpc status %samplerate%)

        if [ "$currentRate" != "$pwrate" ];
        then
          if [[ " ''${allowedRates[*]}" =~ [[:space:]]''${currentRate}[[:space:]] ]];
          then
            pid=$(pgrep qpwgraph)
            kill "$pid"
            pw-metadata -n settings 0 clock.force-rate "$currentRate"
            pwrate=$(pw-metadata -n settings | grep 'clock.force-rate' | cut -d "'" -f 4)

            hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
            hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

          elif [ $(( currentRate % 48000 )) -eq 0 ];
          then
            if [[ " ''${allowedRates[*]}" =~ [[:space:]]192000[[:space:]] ]];
            then
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 192000
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            elif [[ " ''${allowedRates[*]}" =~ [[:space:]]96000[[:space:]] ]];
            then
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 96000
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            elif [[ " ''${allowedRates[*]}" =~ [[:space:]]48000[[:space:]] ]];
            then
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 48000
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            else
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 44100
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            fi

          else
            if [[ " ''${allowedRates[*]}" =~ [[:space:]]88200[[:space:]] ]];
            then
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 88200
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            else
              pid=$(pgrep qpwgraph)
              kill "$pid"
              pw-metadata -n settings 0 clock.force-rate 44100
              pwrate=''${currentRate}

              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph
              hyprctl dispatch exec "[workspace 4 silent]" uwsm app -- qpwgraph

            fi
          fi

        fi

      done
    '')
  ];
}

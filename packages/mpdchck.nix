{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "mpdchck.sh";
  runtimeInputs = [
    pkgs.pipewire
    pkgs.mpc
  ];
  text = ''
    sr () {
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
    }
    while :
    do
      state=$(mpc status %state%)
      if [ "$state" = "playing" ];
      then
        sr
      fi
    done
  '';
}

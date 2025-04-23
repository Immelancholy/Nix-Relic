{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      function print_centered {
           [[ $# == 0 ]] && return 1

           declare -i TERM_COLS="$(tput cols)"
           declare -i str_len="''${#1}"
           [[ $str_len -ge $TERM_COLS ]] && {
                echo "$1";
                return 0;
           }

           declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
           [[ $# -ge 2 ]] && ch="''${2:0:1}" || ch=" "
           filler=""
           for (( i = 0; i < filler_len; i++ )); do
                filler="''${filler}''${ch}"
           done

           printf "%s%s%s" "$filler" "$1" "$filler"
           [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "''${ch}"
           printf "\n"

           return 0
      }
      get_art () {
        song=$(playerctl --player=mpd metadata --format "{{title}}")
        art=$(playerctl --player=mpd metadata --format "{{mpris:artUrl}}")
        if [ "$song" != "$song_old" ]; then
          clear
          kitten icat --align=center "$art"
          line1=$(playerctl --player=mpd metadata --format "-------- {{artist}} --------")
          line2=$(playerctl --player=mpd metadata --format "-------- {{title}} --------")
          print_centered "$line1" " "
          print_centered "$line2" " "
          song_old=$song
        fi
      }

      while :
      do
        state=$(mpc status %state%)
        if [ "$state" = "playing" ]; then
          get_art
        elif [ "$state" = "stopped" ]; then
          song_old=""
          clear
        fi
      done
    '')
  ];
}

{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      stty -echo
      tput civis
      TMP="/tmp"
      COVER="$TMP/albumArt.jpg"
      MUSIC_DIR="$HOME/Music"
      PROG_NAME=$(basename "$0")

      hex_to_rgb () {
        HEX=$(echo "$1" | tr -d '#' | tr '[:lower:]' '[:upper:]')
        DIGITS=$(( ''${#HEX} / 3 ))
        R=$(( 16#''${HEX:$(( DIGITS * 0 )):$DIGITS} ))
        G=$(( 16#''${HEX:$(( DIGITS * 1 )):$DIGITS} ))
        B=$(( 16#''${HEX:$(( DIGITS * 2 )):$DIGITS} ))
      }

      get_colors () {
        config="$XDG_CONFIG_HOME/mpdart"
        colorfile="$config/colors"
        if [ -f "$colorfile" ]; then
          colors=()
          while IFS= read -r color; do
            colors+=("$color")
          done < "$colorfile"

          hex_to_rgb "''${colors[0]}"
          col1=$(printf "\033[38;2;''${R};''${G};''${B}m")

          hex_to_rgb "''${colors[1]}"
          col2=$(printf "\033[38;2;''${R};''${G};''${B}m")

          hex_to_rgb "''${colors[2]}"
          col3=$(printf "\033[38;2;''${R};''${G};''${B}m")

          hex_to_rgb "''${colors[3]}"
          col4=$(printf "\033[38;2;''${R};''${G};''${B}m")

          hex_to_rgb "''${colors[4]}"
          col5=$(printf "\033[38;2;''${R};''${G};''${B}m")

        else
          mkdir -p $config

          col1=$(tput setaf 7)
          col2=$(tput setaf 7)
          col3=$(tput setaf 7)
          col4=$(tput setaf 7)
          col5=$(tput setaf 4)
        fi
      }

      show_help() {
          printf "%s" "\
      usage: mpdart [-h|--help] [--music_dir \"path/to/dir\"]

      optional arguments:
         -h, --help            show this help message and exit
         --music_dir           the music directory which MPD plays from
      "
      }

      options=$(getopt -o h --long 'music_dir:,verbose,help' -- "$@")
      eval set -- "$options"

      while true; do
          case "$1" in
              --music_dir)
                  shift;
                  MUSIC_DIR=$1
                  ;;
              -h|--help)
                  show_help
                  exit
                  ;;
              --)
                  shift
                  break
                  ;;
          esac
          shift
      done

      cleanup () {
        stty echo
        tput cvvis
        clear
        exit 1
      }

      trap cleanup SIGINT

      get_art () {
        song=$(mpc current --format %file%)
        if [ "$song" != "$song_old" ]; then
          clear
          title=$(mpc current --format %title%)
          album=$(mpc current --format %album%)
          DIR="$MUSIC_DIR/$(dirname "$(mpc current -f %file%)")"
          ffmpeg -i "$MUSIC_DIR/$(mpc current -f %file%)" "$COVER" -y &> /dev/null
          if ! [ $? -eq 0 ]; then
            for ART in "$DIR/cover."{png,jpg,webp}; do
              if [ -f "$ART" ]; then
                convert "$ART" $COVER &> /dev/null
              fi
            done
            for ART in "$DIR/../cover."{png,jpg,webp}; do
              if [ -f "$ART" ]; then
                convert "$ART" $COVER &> /dev/null
              fi
            done
          fi
          artist=$(mpc current --format %artist%)
          line1="''${col1}$title"
          line2p1="''${col2}$artist "
          len2p1=''${#artist}
          line2p2="''${col3}- "
          line2p3="''${col4}$album"
          cols_album=$(($cols-$len2p1-3))
          line2p3="''${line2p3:0:$cols_album}"
          line3="''${col5}─────────────────────────────────╶"
          kitten icat --align=center "$COVER"
          printf '%s\n' "$line1"
          printf '%s' "$line2p1"
          printf '%s' "$line2p2"
          printf '%s\n' "$line2p3"
          printf '%s' "$line3"
          song_old=$song
        fi
      }

      FIRST_RUN=true

      main () {
        while :
        do
          state=$(mpc status %state%)
          cols=$(tput cols)
          if [ "$FIRST_RUN" == true ]; then
            FIRST_RUN=false
            cols_old=$cols
            clear
          fi
          if [ "$cols" != "$cols_old" ]; then
            song_old=""
            get_art
            cols_old=$cols
          fi
          if [ "$state" = "playing" ]; then
            get_art
          elif [ "$state" = "stopped" ]; then
            song_old=""
            clear
          fi
          read -rsn1 -t 0.00001 key
          if [ "$key" = 'q' ]; then
            break
          fi
        done
      }

      get_colors
      main
      stty echo
      tput cvvis
      clear
      exit 0
    '')
  ];
}

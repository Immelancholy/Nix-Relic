{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "mpdart" ''
      stty -echo
      tput civis
      source "${inputs.bash-utility}/src/format.sh"
      TMP="/tmp"
      COVER="$TMP/albumArt.jpg"
      MUSIC_DIR="$HOME/Music"
      PROG_NAME=$(basename "$0")

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

      get_art () {
        song=$(mpc current --format %file%)
        if [ "$song" != "$song_old" ]; then
          clear
          title=$(mpc current --format %title%)
          DIR="$MUSIC_DIR/$(dirname "$(mpc current -f %file%)")"
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
          artist=$(mpc current --format %artist%)
          line1="-------- $artist --------"
          line2="-------- $title --------"
          kitten icat --align=center "$COVER"
          format::text_center "$line1"
          format::text_center "$line2"
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
          if [ "$state" = "playing" ]; then
            get_art
            if [ "$cols" != "$cols_old" ]; then
              song_old=""
              get_art
              cols_old=$cols
            fi
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

      main
      stty echo
      tput cvvis
      exit 0
    '')
  ];
}

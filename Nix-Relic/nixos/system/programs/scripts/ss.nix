{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "ss.sh" ''

      USAGE() {
        cat <<"USAGE"

        Usage: screenshot.sh [option]
        Options:
          o     Print output
          a     Select area to screenshot
          af    Select area or window with frozen screen
          w     Print a selected window

      USAGE
      }

      SCREENSHOT_POST_COMMAND+=(
      )

      SCREENSHOT_PRE_COMMAND+=(
      )

      pre_cmd() {
        for cmd in "''${SCREENSHOT_PRE_COMMAND[@]}"; do
          eval "$cmd"
        done
        trap 'post_cmd' EXIT
      }

      post_cmd() {
        for cmd in "''${SCREENSHOT_POST_COMMAND[@]}"; do
          eval "$cmd"
        done
      }

      confDir="''${confDir:-$HOME/.config}"
      save_dir="''${XDG_SCREENSHOTS_DIR}"
      mkdir -p "$save_dir"
      save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
      temp_name="screenshot.png"
      temp_dir="/tmp"
      temp_screenshot="''${temp_dir}/''${temp_name}"

      swpy_dir="''${confDir}/swappy"
      mkdir -p "$swpy_dir"
      echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"''${swpy_dir}"/config

      pre_cmd

      case $1 in
      o) # print output
        hyprshot -z -m output -o $temp_dir -f "$temp_name"
        sleep 1
        swappy -f $temp_screenshot
        ;;

      a) # drag to manually snip an area
        hyprshot -m region -o $temp_dir -f "$temp_name"
        sleep 1
        swappy -f $temp_screenshot        ;;
      af) # frozen screen, drag to manually snip an area
        hyprshot -z -m region -o $temp_dir -f "$temp_name"
        sleep 1
        swappy -f $temp_screenshot        ;;
      w) # frozen screen, click window to screenshot
        hyprshot -z -m window -o $temp_dir -f "$temp_name"
        sleep 1
        swappy -f $temp_screenshot
        ;;
      *) # invalid option
        USAGE ;;
      esac

      [ -f "$temp_screenshot" ] && rm "$temp_screenshot"
    '')
  ];
}

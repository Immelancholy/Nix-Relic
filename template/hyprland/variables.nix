{ config, ... }:
let
  inherit (config.wayland.windowManager.hyprland) liveWallpaper;
  inherit (config.player) cmd class title;
  inherit (config.stylix.cursor) name size;

  wallpaper = "${
    if liveWallpaper.enable then
      ''
        local wallpaper = "${liveWallpaper.path}"
          hl.exec_cmd("uwsm-app -- mpvpaper -f -p -o \"--loop no-audio\" '*' " .. wallpaper)
          hl.exec_cmd("sleep 2; systemctl stop --user hyprpaper")''
    else
      ""
  }";
  wallpaperKill = "${
    if liveWallpaper.enable then
      ''
        hl.exec_cmd("systemctl start --user hyprpaper")
          hl.exec_cmd("pkill mpvpaper")''
    else
      ""
  }";
in
{
  xdg.configFile."hypr/variables.lua".text = /* Lua */ ''
    function LiveWallpaper()
      ${wallpaper}
    end

    function LiveWallpaperKill()
      ${wallpaperKill}
    end

    Cursor = "${name} ${toString size}"
    Term = "uwsm-app -- kitty"
    Browser = "uwsm-app -- zen-beta.desktop"
    Discord = "uwsm-app -- vesktop.desktop"
    Editor = Term .. " nvim"
    Files = Term .. " yazi"
    Menu =
      'rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'
    Mod = "SUPER"
    Moda = "SUPER + ALT"
    Modc = "SUPER + CTRL"
    Mods = "SUPER + SHIFT"
    Player = Term .. " --title ${title} --class ${class} ${cmd}"
    Playerctl = "uwsm-app -- playerctl --player=${class}"
    PlayerTitle = "${title}"
  '';
}

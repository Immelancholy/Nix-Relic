{
  pkgs,
  config,
  ...
}: let
  wallpaper = config.wayland.windowManager.hyprland.liveWallpaper.path;
  player = config.player.cmd;
  pclass = config.player.class;
in {
  home.packages = [
    (pkgs.writeShellScriptBin "hyprgame" ''
      HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '1p' | awk '{print $2}')

      # Hyprland performance
      if [ "$HYPRGAMEMODE" = 1 ]; then
              hyprctl -q --batch "\
              keyword animations:enabled 0;\
              keyword decoration:shadow:enabled 0;\
              keyword decoration:shadow:xray 1;\
              keyword decoration:blur:enabled 0;\
              keyword general:gaps_in 0;\
              keyword general:gaps_out 0;\
              keyword general:border_size 1;\
              keyword decoration:rounding 0 ;\
              keyword decoration:active_opacity 1 ;\
              keyword decoration:inactive_opacity 1 ;\
              keyword decoration:fullscreen_opacity 1 ;\
              keyword decoration:fullscreen_opacity 1 ;\
              keyword layerrule noanim,waybar ;\
              keyword layerrule noanim,mpvpaper ;\
              keyword layerrule noanim,rofi
              "
              hyprctl 'keyword windowrule opaque,class:(.*)' # ensure all windows are opaque
              hyprctl dispatch signalwindow class:neo,9
              hyprctl dispatch signalwindow class:cava,9
              hyprctl dispatch signalwindow class:btop,9
              hyprctl dispatch signalwindow class:${pclass},9
              hyprctl dispatch signalwindow class:fastfetch,9
              pkill mpvpaper
              systemctl stop --user mpdchck
              hyprctl dispatch exec '[workspace 1 silent; float; size 1118 710; move 401 145] ${player}'
              exit
      else
              hyprctl dispatch signalwindow class:${pclass},9
              hyprctl reload config-only -q
              uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto --no-audio" '*' ${wallpaper}
              systemctl start --user mpdchck
              hyprctl dispatch exec '[workspace 1 silent; float; size 858 559; move 640 40] ${player}'
              hyprctl dispatch exec '[workspace 1 silent; float; size 858 462; move 640 609] uwsm app -- kitty --class "cava" cava.sh'
              hyprctl dispatch exec '[workspace 1 silent; float; size 620 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
              hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 40] uwsm app -- kitty --class "neo" neo.sh'
              hyprctl dispatch exec '[workspace 1 silent; float; size 620 383; move 10 40] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
      fi
    '')
  ];
}

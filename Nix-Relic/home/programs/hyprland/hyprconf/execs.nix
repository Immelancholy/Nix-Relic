{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Ice 22"
      "systemctl stop --user hyprpaper"
      "systemctl restart --user nm-applet"
      "sleep 10; systemctl restart --user remmina"
      ''uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto" '*' $HOME/Pictures/wallpapers/Neon-Beast-Girl.mp4''
      ''[workspace 1 silent; float; size 858 559; move 640 40] $term --class "rmpc" uwsm app -- rmpc.sh''
      ''[workspace 1 silent; float; size 858 462; move 640 609] $term --class "cava" uwsm app -- cava.sh''
      ''[workspace 1 silent; float; size 620 666; move 10 404] $term --class "btop" uwsm app -- btop.sh''
      ''[workspace 1 silent; float; size 402 1030; move 1508 40] $term --class "neo" uwsm app -- neo.sh''
      ''[workspace 1 silent; float; size 620 354; move 10 40] $term --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"''
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] uwsm app -- teams-for-linux --minimized"
      "uwsm app -- $discord"
    ];
  };
}

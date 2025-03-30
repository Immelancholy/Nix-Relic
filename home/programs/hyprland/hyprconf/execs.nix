{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl restart --user nm-applet"
      "systemctl stop --user cliphist cliphist-images remmina"
      "uwsm app -s b -- $scr/mpdchck.sh"
      ''uwsm app -- mpvpaper -o "--loop" '*' $HOME/Pictures/wallpapers/Neon-Beast-Girl.mp4''
      # "uwsm app -- wl-paste --type text --watch cliphist store # Stores only image data"
      # "uwsm app -- wl-paste --type image --watch cliphist store # Stores only image data"
      ''[workspace 1 silent; float; size 858 559; move 640 40] $term --class "rmpc" uwsm app -- $scr/rmpc.sh''
      ''[workspace 1 silent; float; size 858 462; move 640 609] $term --class "cava" uwsm app -- $scr/cava.sh''
      ''[workspace 1 silent; float; size 620 666; move 10 404] $term --class "btop" uwsm app -- $scr/btop.sh''
      ''[workspace 1 silent; float; size 402 1030; move 1508 40] $term --class "neo" uwsm app -- $scr/neo.sh''
      ''[workspace 1 silent; float; size 620 354; move 10 40] $term kitty @ launch --type overlay --env class="fastfetch"''
      "[workspace 4 silent] uwsm app -- qpwgraph"
      "[workspace 4 silent] uwsm app -- qpwgraph"
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] uwsm app -- teams-for-linux --minimized"
      "[workspace 3] sleep 1; uwsm app -- DiscordCanary"
      "sleep 12; systemctl restart --user cliphist cliphist-images remmina solaar" #These services tried to start to early idk
    ];
  };
}

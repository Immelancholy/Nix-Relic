{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "uwsm app -- hyprctl setcursor Bibata-Modern-Ice 20"
      "uwsm app -- $scr/swww.sh"
      # "swayidle -w"
      "uwsm app -- linux-wallpaperengine --screen-root HDMI-A-1 $HOME/.local/share/Steam/steamapps/workshop/content/431960/3293827865 --fps 144"
      "uwsm app -- wl-paste --type text --watch cliphist store # Stores only image data"
      "uwsm app -- wl-paste --type image --watch cliphist store # Stores only image data"
      "[workspace 1 silent; float; size 858 559; move 640 40] uwsm app -- $term $scr/rmpc.sh"
      "[workspace 1 silent; float; size 858 462; move 640 609] uwsm app -- $term $scr/cava.sh"
      "[workspace 1 silent; float; size 620 666; move 10 404] uwsm app -- $term $scr/btop.sh"
      "[workspace 1 silent; float; size 402 1030; move 1508 40] uwsm app -- $term $scr/neo.sh"
      "[workspace 1 silent; float; size 620 354; move 10 40] uwsm app -- $term --hold fastfetch --logo $HOME/Pictures/fastfetch_logos/FallenAngel.jpg"
      "[workspace 4 silent] uwsm app -- qpwgraph"
      "[workspace 2 silent] uwsm app -- $browser"
      "[workspace 2 silent] uwsm app -- teams-for-linux --minimized"
      "[workspace 3] uwsm app -- Discord --enable-features=UseOzonePlatform --ozone-platform=x11"
    ];
  };
}

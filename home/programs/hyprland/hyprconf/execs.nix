{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "hyprctl setcursor Bibata-Modern-Ice 20"
      "$scr/swww.sh"
      "wl-paste --type text --watch cliphist store # Stores only image data"
      "wl-paste --type image --watch cliphist store # Stores only image data"
      "[workspace 1 silent; float; size 858 559; move 640 40] $term $scr/rmpc.sh"
      "[workspace 1 silent; float; size 858 462; move 640 609] $term $scr/cava.sh"
      "[workspace 1 silent; float; size 620 666; move 10 404] $term $scr/btop.sh"
      "[workspace 1 silent; float; size 402 1030; move 1508 40] $term $scr/neo.sh"
      "[workspace 1 silent; float; size 620 354; move 10 40] $term --hold fastfetch"
      "[workspace 4 silent] qpwgraph"
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] teams-for-linux --minimized"
      "[workspace 3] discord"
    ];
  };
}

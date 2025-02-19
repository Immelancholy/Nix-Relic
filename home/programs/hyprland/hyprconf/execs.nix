{
  wayland.windowManager.hyprland.settings = {
    exec = [
      "hyprctl setcursor Bibata-Modern-Ice 20"
    ];
    exec-once = [
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "$scr/swww.sh"
      "[workspace 2 silent] mullvad-vpn"
      "[workspace 1 silent; float; size 854 555; move 646 40] $term sh $scr/rmpc.sh"
      "[workspace 1 silent; float; size 854 465; move 646 605] $term sh $scr/cava.sh"
      "[workspace 1 silent; float; size 626 666; move 10 404] $term sh $scr/btop.sh"
      "[workspace 1 silent; float; size 400 1030; move 1510 40] $term sh $scr/neo.sh"
      "[workspace 1 silent; float; size 626 354; move 10 40] $term --hold fastfetch"
      "[workspace 4 silent] qpwgraph"
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] teams-for-linux --minimized"
      "[workspace 3] sleep 3; discord"
      "[workspace 5 silent] easyeffects"
    ];
  };
}

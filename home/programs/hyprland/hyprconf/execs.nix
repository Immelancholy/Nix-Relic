{
  wayland.windowManager.hyprland.settings = {
    exec = [
      "hyprctl setcursor Bibata-Modern-Ice 20"
    ];
    exec-once = [
      "$scr/swww.sh"
      "[workspace 1 silent; float; size 854 557; move 646 38] $term sh $scr/rmpc.sh"
      "[workspace 1 silent; float; size 854 465; move 646 605] $term sh $scr/cava.sh"
      "[workspace 1 silent; float; size 626 638; move 10 432] $term sh $scr/btop.sh"
      "[workspace 1 silent; float; size 400 1032; move 1510 38] $term sh $scr/neo.sh"
      "[workspace 1 silent; float; size 626 384; move 10 38] $term --hold fastfetch"
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] teams-for-linux --minimized"
      "[workspace 2 silent] mullvad-vpn"
      "[workspace 3] discord"
      "[workspace 4 silent] qpwgraph"
      "[workspace 5 silent] easyeffects"
    ];
  };
}

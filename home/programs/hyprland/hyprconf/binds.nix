{
  wayland.windowManager.hyprland.settings = {
    bind = [ 
      "$mod, T, exec, $term"
      "$mod, Q, killactive"
      "$mod, F, exec, $browser"
      "$mod, E, exec, $files"
      "$mod, A, exec, $menu"
      "$mod, C, exec, $edit"
      "$mod, W, togglefloating"
      "$mod, G, togglegroup"
      "Alt, Return, fullscreen"
      "$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
      "$mod+Ctrl+Alt, Left, movetoworkspace, r-1"
      "$mod, I, exec, [workspace 1 silent; float; size 854 557; move 646 38]$term sh $scr/rmpc.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 854 465; move 646 605]$term sh $scr/cava.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 626 638; move 10 432]$term sh $scr/btop.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 400 1032; move 1510 38]$term sh $scr/neo.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 626 384; move 10 37]$term --hold fastfetch" 

    ]
    ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
}

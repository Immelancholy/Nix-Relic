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

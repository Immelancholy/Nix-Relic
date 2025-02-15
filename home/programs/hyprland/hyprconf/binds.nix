{
  wayland.windowManager.hyprland.settings = {
    bind = [ 
      "$mod, T, exec, $term --hold sh $scr/poke.sh"
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
      "$mod, Delete, exec, uwsm stop"
      "$mod+Shift, 0, movetoworkspace, 10"
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
  wayland.windowManager.hyprland.extraConfig = '' 
    bindl  = , XF86AudioMute, exec, playerctl --player=mpd play-pause #pause-play media
    bindel = , XF86AudioLowerVolume, exec, playerctl --player=mpd volume 0.01- # decrease volume
    bindel = , XF86AudioRaiseVolume, exec, playerctl --player=mpd volume 0.01+ # increase volume
    bindl  = , mouse:277, exec, playerctl --player=mpd play-pause # toggle between media play and pause
    bindel  = , mouse:281, exec, playerctl --player=mpd volume 0.01+ # volume up
    bindel  = , mouse:282, exec, playerctl --player=mpd volume 0.01- # volume down
    bindl  = $mod, mouse:282, exec, playerctl --player=mpd next #next
    bindl  = $mod, mouse:281, exec, playerctl --player=mpd previous #previous,
    bindl = , mouse:275, pass, class:^(discord)$
    bindl = , F10, pass, class:^(com.obsproject.Studio)$
    bindl = , F12, pass, class:^(com.obsproject.Studio)$
    bindl = , F9, pass, class:^(com.obsproject.Studio)$
    bind = $mod, M, exec,[workspace 4 silent] /home/mela/scripts/patch.sh
    bind = $mod, M, exec,[workspace 4 silent] qpwgraph

    bind = $mod, H, movefocus, l
    bind = $mod, L, movefocus, r
    bind = $mod, K, movefocus, u
    bind = $mod, J, movefocus, d
    bind = Alt, Tab, movefocus, d
    bind = $mod, Left, movefocus, l
    bind = $mod, Right, movefocus, r
    bind = $mod, Up, movefocus, u
    bind = $mod, Down, movefocus, d

    bind = $mod+Ctrl, L, workspace, r+1
    bind = $mod+Ctrl, H, workspace, r-1
    bind = $mod+Ctrl, Right, workspace, r+1
    bind = $mod+Ctrl, Left, workspace, r-1


    bind = $mod+Ctrl, J, workspace, empty 

    binde = $mod+Shift, H, resizeactive, 1 0
    binde = $mod+Shift, L, resizeactive, -1 0
    binde = $mod+Shift, K, resizeactive, 0 -1
    binde = $mod+Shift, J, resizeactive, 0 1
    binde = $mod+Shift, Left, resizeactive, 1 0
    binde = $mod+Shift, Right, resizeactive, -1 0
    binde = $mod+Shift, Up, resizeactive, 0 -1
    binde = $mod+Shift, Down, resizeactive, 0 1

    $moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
    binded = $mod+Shift+Ctrl, H, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
    binded = $mod+Shift+Ctrl, L, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
    binded = $mod+Shift+Ctrl, K, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
    binded = $mod+Shift+Ctrl, J, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d
    binded = $mod+Shift+Ctrl, Left, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
    binded = $mod+Shift+Ctrl, Right, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
    binded = $mod+Shift+Ctrl, Up, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
    binded = $mod+Shift+Ctrl, Down, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d

    bind = $mod, mouse_up, workspace, e+1
    bind = $mod, mouse_down, workspace, e-1

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
    bindm = $mod, Z, movewindow
    bindm = $mod, X, resizewindow

    bind = $mod+Alt, S, movetoworkspacesilent, special
    bind = $mod, S, togglespecialworkspace,

    bind = $mod, R, togglesplit

    bind = Ctrl+Shift, Escape, exec, $term --title "btop" sh $scr/btop.sh
    
    bindd = $mod+Shift, P,Color Picker , exec, hyprpicker -a # Pick color (Hex) >> clipboard# 

  '';
}

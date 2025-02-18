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
      "$mod, I, exec, [workspace 1 silent; float; size 854 555; move 646 40] $term sh $scr/rmpc.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 854 465; move 646 605] $term sh $scr/cava.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 626 666; move 10 404] $term sh $scr/btop.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 400 1030; move 1510 40] $term sh $scr/neo.sh"
      "$mod, I, exec, [workspace 1 silent; float; size 626 354; move 10 40] $term --hold fastfetch" 
      "$mod, Delete, exec, uwsm stop"
      "$mod+Shift, 0, movetoworkspace, 10"
      ", Print, exec, grimblast --notify copysave output"
      "$mod+Shift, L, exec, swaylock-fancy"
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
    bind = $mod, M, exec,[workspace 4 silent] $scr/patch.sh
    bind = $mod, M, exec,[workspace 4 silent] qpwgraph

    bind = $mod, H, movefocus, l
    bind = $mod, L, movefocus, r
    bind = $mod, K, movefocus, u
    bind = $mod, J, movefocus, d
    bind = $mod, Left, movefocus, l
    bind = $mod, Right, movefocus, r
    bind = $mod, Up, movefocus, u
    bind = $mod, Down, movefocus, d

    bind = $mod+Ctrl, L, workspace, r+1
    bind = $mod+Ctrl, H, workspace, r-1
    bind = $mod+Ctrl, Right, workspace, r+1
    bind = $mod+Ctrl, Left, workspace, r-1

    bind = $mod+Ctrl, J, workspace, empty 
    bind = $mod+Ctrl, Down, workspace, empty

    binde = $mod+Shift, Left, resizeactive, 1 0
    binde = $mod+Shift, Right, resizeactive, -1 0
    binde = $mod+Shift, Up, resizeactive, 0 -1
    binde = $mod+Shift, Down, resizeactive, 0 1

    $moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
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

    bind = , XF86Calculator, exec, qalculate-gtk
    bind = Alt, tab, hyprtasking:toggle, cursor
    bind = SUPER, space, hyprtasking:toggle, all

    bind = SUPER, Q, hyprtasking:killhovered

    bind = Alt, H, hyprtasking:move, left
    bind = Alt, J, hyprtasking:move, down
    bind = Alt, K, hyprtasking:move, up
    bind = Alt, L, hyprtasking:move, right

    plugin {
        hyprtasking {
            layout = grid

            gap_size = 20
            bg_color = 0xff26233a
            border_size = 2
            exit_behavior = active interacted original hovered

            gestures {
                enabled = true
                open_fingers = 3
                open_distance = 300
                open_positive = true
            }

            grid {
                rows = 3
                cols = 3
            }

            linear {
                height = 400
                scroll_speed = 1.1
                blur = 0
            }
        }
    }
  '';
}

{
  wayland.windowManager.hyprland.settings = {
    bindl = [
    ];
    bind =
      [
        "$mod, T, exec, $term --hold $scr/poke.sh"
        "$mod+Shift, T, exec, $term $scr/tmux_start.sh"
        "$mod, F, exec, $browser"
        "$mod, E, exec, $files"
        "$mod, A, exec, $menu"
        "$mod, C, exec, $edit"
        "$mod, W, togglefloating"
        "$mod, G, togglegroup"
        "$mod, Q, killactive"
        "$mod, R, exec, $files2"
        "Alt, Return, fullscreen"
        "$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
        "$mod+Ctrl+Alt, Left, movetoworkspace, r-1"
        "$mod+Ctrl+Alt, L, movetoworkspace, r+1"
        "$mod+Ctrl+Alt, H, movetoworkspace, r-1"
        "$mod, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] $term $scr/rmpc.sh"
        "$mod, U, exec, [workspace 1 silent; float; size 858 462; move 640 609] $term $scr/cava.sh"
        "$mod, U, exec, [workspace 1 silent; float; size 620 666; move 10 404] $term $scr/btop.sh"
        "$mod, U, exec, [workspace 1 silent; float; size 402 1030; move 1508 40] $term $scr/neo.sh"
        "$mod, U, exec, [workspace 1 silent; float; size 620 354; move 10 40] $term --hold fastfetch"
        "$mod, Delete, exec, uwsm stop"
        "$mod+Shift, 0, movetoworkspace, 10"
        ", Print, exec, $scr/screenshot.sh m"
        "$mod, Print, exec, $scr/screenshot.sh sf"
        "$mod+Shift, Print, exec, $scr/screenshot.sh s"
        "$mod+Shift+Alt, Print, exec, $scr/screenshot.sh p"
        "Alt, P, exec, $scr/screenshot.sh m"
        "Alt+Shift, P, exec, $scr/screenshot.sh sf"
        "Alt+Shift+Ctrl, P, exec, $scr/screenshot.sh p"
        "Ctrl+Alt, L, exec, swaylock"
        "$mod, D, exec, $term $scr/tmux_nix.sh"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
  wayland.windowManager.hyprland.extraConfig = ''
    bindl  = , XF86AudioMute, exec, $playerctl play-pause #pause-play media
    bindel = , XF86AudioLowerVolume, exec, rmpc volume -1 # decrease volume
    bindel = , XF86AudioRaiseVolume, exec, rmpc volume +1 # increase volume

    bindl  = , mouse:277, exec, $playerctl play-pause # toggle between media play and pause
    bindl = $mod, P, exec, $playerctl play-pause
    bindel  = , mouse:281, exec, rmpc volume +1 # volume up
    bindel  = , mouse:282, exec, rmpc volume -1 # volume down
    bindel  = $mod, O, exec, rmpc volume +1 # volume up
    bindel  = $mod, I, exec, rmpc volume -1 # volume down
    bindl  = $mod, mouse:282, exec, $playerctl next #next
    bindl  = $mod, mouse:281, exec, $playerctl previous #previous,
    bindl = , mouse:275, pass, class:^(discord)$
    bindl = , F10, pass, class:^(com.obsproject.Studio)$
    bindl = , F12, pass, class:^(com.obsproject.Studio)$
    bindl = , F9, pass, class:^(com.obsproject.Studio)$
    bind = $mod, M, exec,[workspace 4 silent] $scr/patch.sh
    bind = $mod, M, exec,[workspace 4 silent] qpwgraph
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
    bind = $mod+Ctrl, J, workspace, empty
    bind = $mod+Ctrl, Right, workspace, r+1
    bind = $mod+Ctrl, Left, workspace, r-1
    bind = $mod+Ctrl, Down, workspace, empty


    binde = $mod+Shift, Left, resizeactive, 1 0
    binde = $mod+Shift, Right, resizeactive, -1 0
    binde = $mod+Shift, Up, resizeactive, 0 -1
    binde = $mod+Shift, Down, resizeactive, 0 1
    binde = $mod+Shift, H, resizeactive, 30 0
    binde = $mod+Shift, L, resizeactive, -30 0
    binde = $mod+Shift, K, resizeactive, 0 -30
    binde = $mod+Shift, J, resizeactive, 0 30

    $moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
    binded = $mod+Ctrl+Shift, Left, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
    binded = $mod+Ctrl+Shift, Right, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
    binded = $mod+Ctrl+Shift, Up, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
    binded = $mod+Ctrl+Shift, Down, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d
    binded = $mod+Ctrl+Shift, H, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
    binded = $mod+Ctrl+Shift, L, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
    binded = $mod+Ctrl+Shift, K, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u
    binded = $mod+Ctrl+Shift, J, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d

    bind = $mod, mouse_up, workspace, e+1
    bind = $mod, mouse_down, workspace, e-1

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
    bind = $mod+Alt, S, movetoworkspacesilent, special
    bind = $mod, S, togglespecialworkspace,

    bind = $mod, B, togglesplit

    bind = Ctrl+Shift, Escape, exec, $term --title "btop" sh $scr/btop.sh

    bindd = $mod+Shift, P,Color Picker , exec, hyprpicker -a # Pick color (Hex) >> clipboard#

    bind = , XF86Calculator, exec, qalculate-gtk
  '';
}

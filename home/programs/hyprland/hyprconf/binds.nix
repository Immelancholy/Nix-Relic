{
  wayland.windowManager.hyprland.settings = {
    bindl = [
    ];
    bind =
      [
        "$mod, T, exec, $term"
        ''$mods, T, exec, $term --class "tmux" tmux''
        "$mod, F, exec, $browser"
        "$mod, E, exec, $files"
        "$mod, grave, exec, $menu"
        "$mod, V, exec, $edit"
        "$mod, W, togglefloating"
        "$mod, Tab, hy3:togglefocuslayer"
        "$mod, D, hy3:makegroup, h"
        "$mod, S, hy3:makegroup, v"
        "$mod, Z, hy3:makegroup, tab"
        "$mod, A, hy3:changefocus, raise"
        "$mods, A, hy3:changefocus, lower"
        "$mod, C, hy3:expand, expand"
        "$mods, C, hy3:expand, base"
        "$mod, R, hy3:changegroup, opposite"

        "$mods, Q, hy3:killactive"
        "Alt, Return, fullscreen"
        # "$mod+Ctrl+Alt, Right, hy3:movetoworkspace, r+1, follow"
        # "$mod+Ctrl+Alt, Left, hy3:movetoworkspace, r-1, follow"
        # "$mod+Ctrl+Alt, L, hy3:movetoworkspace, r+1, follow"
        # "$mod+Ctrl+Alt, H, hy3:movetoworkspace, r-1, follow"
        "$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
        "$mod+Ctrl+Alt, Left, movetoworkspace, r-1"
        "$mod+Ctrl+Alt, L, movetoworkspace, r+1"
        "$mod+Ctrl+Alt, H, movetoworkspace, r-1"
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] $term --class "rmpc" uwsm app -- $scr/rmpc.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 858 462; move 640 609] $term --class "cava" uwsm app -- cava.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 666; move 10 404] $term --class "btop" uwsm app -- btop.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 402 1030; move 1508 40] $term --class "neo" uwsm app -- $scr/neo.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 354; move 10 40] $term --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"''
        "$mod, Delete, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
        "$mods, 0, hy3:movetoworkspace, 10"
        "$mod, 0, workspace, 10"
        "$mod+Ctrl, 0, hy3:focustab, index, 10"
        "Ctrl+Alt, L, exec, uwsm-app -- swaylock -fF"
        ''$mod, G, exec, $term --class "NixDots" uwsm app -- $scr/tmux_nix.sh''
        "$mod, N, exec, uwsm-app -- $scr/cliphist.sh"
        " , Print, exec, uwsm-app -- $scr/ss.sh o"
        "$mod, Print, exec, uwsm-app -- $scr/ss.sh af"
        "$mods, Print, exec, uwsm-app -- $scr/ss.sh w"
        "Ctrl, Print, exec, uwsm-app -- $scr/ss.sh af"
        "Ctrl Shift, Print, exec, uwsm-app -- $scr/ss.sh w"
        "Alt+Shift, Tab, exec, rofi -show window -modi window"
        "$mod, M, exec, hyprgame"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mods, code:1${toString i}, hy3:movetoworkspace, ${toString ws}"
              "$mod+Ctrl, code:1${toString i}, hy3:focustab, index, 0${toString ws}"
            ]
          )
          9)
      );
  };
  wayland.windowManager.hyprland.extraConfig = ''
    bindl  = , XF86AudioMute, exec, $playerctl play-pause #pause-play media
    bindel = , XF86AudioLowerVolume, exec, uwsm-app -- rmpc volume -1 # decrease volume
    bindel = , XF86AudioRaiseVolume, exec, uwsm-app -- rmpc volume +1 # increase volume

    bindl  = , mouse:277, exec, $playerctl play-pause # toggle between media play and pause
    bindl = $mod, P, exec, $playerctl play-pause
    bindel  = , mouse:281, exec, uwsm-app -- rmpc volume +1 # volume up
    bindel  = , mouse:282, exec, uwsm-app -- rmpc volume -1 # volume down
    bindel  = $mod, O, exec, uwsm-app -- rmpc volume +1 # volume up
    bindel  = $mod, I, exec, uwsm-app -- rmpc volume -1 # volume down
    bindl  = $mod, mouse:282, exec, $playerctl next #next
    bindl  = $mod, mouse:281, exec, $playerctl previous #previous,
    bindl = , mouse:275, pass, class:^(discord)$
    bindl = , F10, pass, class:^(com.obsproject.Studio)$
    bindl = , F12, pass, class:^(com.obsproject.Studio)$
    bindl = , F9, pass, class:^(com.obsproject.Studio)$
    bindl = Alt, F10, pass, class:^(com.obsproject.Studio)$

    bind = $mod, H, hy3:movefocus, l, once
    bind = $mod, J, hy3:movefocus, d, once
    bind = $mod, K, hy3:movefocus, u, once
    bind = $mod, L, hy3:movefocus, r, once
    bind = $mod, Left, hy3:movefocus, l, once
    bind = $mod, Down, hy3:movefocus, d, once
    bind = $mod, Up, hy3:movefocus, u, once
    bind = $mod, Right, hy3:movefocus, r, once

    bind = $mod+Alt, H, hy3:movefocus, l, visible, nowarp
    bind = $mod+Alt, J, hy3:movefocus, d, visible, nowarp
    bind = $mod+Alt, K, hy3:movefocus, u, visible, nowarp
    bind = $mod+Alt, L, hy3:movefocus, r, visible, nowarp
    bind = $mod+Alt, Left, hy3:movefocus, l, visible, nowarp
    bind = $mod+Alt, Down, hy3:movefocus, d, visible, nowarp
    bind = $mod+Alt, Up, hy3:movefocus, u, visible, nowarp
    bind = $mod+Alt, Right, hy3:movefocus, r, visible, nowarp

    bind = $mod+Ctrl, L, workspace, r+1
    bind = $mod+Ctrl, H, workspace, r-1
    bind = $mod+Ctrl, J, workspace, empty
    bind = $mod+Ctrl, Right, workspace, r+1
    bind = $mod+Ctrl, Left, workspace, r-1
    bind = $mod+Ctrl, Down, workspace, empty


    binde = $mod+Ctrl+Shift, Left, resizeactive, 1 0
    binde = $mod+Ctrl+Shift, Right, resizeactive, -1 0
    binde = $mod+Ctrl+Shift, Up, resizeactive, 0 -1
    binde = $mod+Ctrl+Shift, Down, resizeactive, 0 1
    binde = $mod+Ctrl+Shift, H, resizeactive, 30 0
    binde = $mod+Ctrl+Shift, L, resizeactive, -30 0
    binde = $mod+Ctrl+Shift, K, resizeactive, 0 -30
    binde = $mod+Ctrl+Shift, J, resizeactive, 0 30

    # $moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
    # binded = $mod+Shift, Left, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch hy3:movewindow l
    # binded = $mod+Shift, Right, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch hy3:movewindow r
    # binded = $mod+Shift, Up, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch hy3:movewindow u
    # binded = $mod+Shift, Down, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch hy3:movewindow d
    # binded = $mod+Shift, H, Move activewindow left, exec, $moveactivewindow -30 0 || hyprctl dispatch hy3:movewindow l
    # binded = $mod+Shift, L, Move activewindow right, exec, $moveactivewindow 30 0 || hyprctl dispatch hy3:movewindow r
    # binded = $mod+Shift, K, Move activewindow up, exec, $moveactivewindow  0 -30 || hyprctl dispatch hy3:movewindow u
    # binded = $mod+Shift, J, Move activewindow down, exec, $moveactivewindow 0 30 || hyprctl dispatch hy3:movewindow d

    bind = $mod+Shift, H, hy3:movewindow, l
    bind = $mod+Shift, H, hy3:warpcursor
    bind = $mod+Shift, J, hy3:movewindow, d
    bind = $mod+Shift, J, hy3:warpcursor
    bind = $mod+Shift, K, hy3:movewindow, u
    bind = $mod+Shift, K, hy3:warpcursor
    bind = $mod+Shift, L, hy3:movewindow, r
    bind = $mod+Shift, L, hy3:warpcursor
    bind = $mod+Shift, Right, hy3:movewindow, r
    bind = $mod+Shift, Right, hy3:warpcursor
    bind = $mod+Shift, Down, hy3:movewindow, d
    bind = $mod+Shift, Down, hy3:warpcursor
    bind = $mod+Shift, Up, hy3:movewindow, u
    bind = $mod+Shift, Up, hy3:warpcursor
    bind = $mod+Shift, Left, hy3:movewindow, l
    bind = $mod+Shift, Left, hy3:warpcursor

    bind = $mod, mouse_up, workspace, e+1
    bind = $mod, mouse_down, workspace, e-1

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
    bindn = , mouse_down, hy3:focustab, r, require_hovered
    bindn = , mouse_up, hy3:focustab, l, require_hovered
    bind = $mod, Q, hy3:warpcursor
    bind = $mods, X, hy3:movetoworkspace, special
    bind = $mod, X, togglespecialworkspace,

    # bind = $mod, B, togglesplit
    bind = $mod, B, hy3:changegroup, opposite

    bind = Ctrl+Shift, Escape, exec, $term --class "btop" uwsm app -- btop

    bindd = $mod+Shift, P,Color Picker , exec, uwsm-app -- hyprpicker -a # Pick color (Hex) >> clipboard#

    bind = , XF86Calculator, exec, uwsm-app -- qalculate-gtk
  '';
}

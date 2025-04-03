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
        "$mod, H, hy3:changefocus, raise"
        "$mods, H, hy3:changefocus, lower"
        "$mod, C, hy3:expand, expand"
        "$mods, C, hy3:expand, base"
        "$mod, R, hy3:changegroup, opposite"

        "$mods, Q, hy3:killactive"
        "Alt, Return, fullscreen, 1"
        "Alt+Shift, Return, fullscreen"
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] $term --class "rmpc" uwsm app -- rmpc.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 858 462; move 640 609] $term --class "cava" uwsm app -- cava.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 666; move 10 404] $term --class "btop" uwsm app -- btop.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 402 1030; move 1508 40] $term --class "neo" uwsm app -- neo.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 354; move 10 40] $term --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"''
        "$mod, Delete, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
        "$mods, 0, hy3:movetoworkspace, 10"
        "$mod, 0, workspace, 10"
        "$mod+Ctrl, 0, hy3:focustab, index, 10"
        "Ctrl+Alt, L, exec, uwsm-app -- swaylock -fF"
        ''$mod, G, exec, $term --class "NixDots" uwsm app -- tnix''
        "$mod, N, exec, uwsm-app -- cliphist.sh"
        " , Print, exec, uwsm-app -- ss.sh o"
        "$mod, Print, exec, uwsm-app -- ss.sh af"
        "$mods, Print, exec, uwsm-app -- ss.sh w"
        "Ctrl, Print, exec, uwsm-app -- ss.sh af"
        "Ctrl Shift, Print, exec, uwsm-app -- ss.sh w"
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

    bind = $mod, A, submap, move
    submap = move
    bind = , H, hy3:movefocus, l, once
    bind = , J, hy3:movefocus, d, once
    bind = , K, hy3:movefocus, u, once
    bind = , L, hy3:movefocus, r, once
    bind = , Left, hy3:movefocus, l, once
    bind = , Down, hy3:movefocus, d, once
    bind = , Up, hy3:movefocus, u, once
    bind = , Right, hy3:movefocus, r, once

    bind = Ctrl, Right, movetoworkspace, r+1
    bind = Ctrl, Left, movetoworkspace, r-1
    bind = Ctrl, L, movetoworkspace, r+1
    bind = Ctrl, H, movetoworkspace, r-1

    bind = Alt, H, hy3:movefocus, l, visible, nowarp
    bind = Alt, J, hy3:movefocus, d, visible, nowarp
    bind = Alt, K, hy3:movefocus, u, visible, nowarp
    bind = Alt, L, hy3:movefocus, r, visible, nowarp
    bind = Alt, Left, hy3:movefocus, l, visible, nowarp
    bind = Alt, Down, hy3:movefocus, d, visible, nowarp
    bind = Alt, Up, hy3:movefocus, u, visible, nowarp
    bind = Alt, Right, hy3:movefocus, r, visible, nowarp



    binde = Ctrl+Shift, Left, resizeactive, 1 0
    binde = Ctrl+Shift, Right, resizeactive, -1 0
    binde = Ctrl+Shift, Up, resizeactive, 0 -1
    binde = Ctrl+Shift, Down, resizeactive, 0 1
    binde = Ctrl+Shift, H, resizeactive, 30 0
    binde = Ctrl+Shift, L, resizeactive, -30 0
    binde = Ctrl+Shift, K, resizeactive, 0 -30
    binde = Ctrl+Shift, J, resizeactive, 0 30

    bind = Shift, H, hy3:movewindow, l
    bind = Shift, H, hy3:warpcursor
    bind = Shift, J, hy3:movewindow, d
    bind = Shift, J, hy3:warpcursor
    bind = Shift, K, hy3:movewindow, u
    bind = Shift, K, hy3:warpcursor
    bind = Shift, L, hy3:movewindow, r
    bind = Shift, L, hy3:warpcursor
    bind = Shift, Right, hy3:movewindow, r
    bind = Shift, Right, hy3:warpcursor
    bind = Shift, Down, hy3:movewindow, d
    bind = Shift, Down, hy3:warpcursor
    bind = Shift, Up, hy3:movewindow, u
    bind = Shift, Up, hy3:warpcursor
    bind = Shift, Left, hy3:movewindow, l
    bind = Shift, Left, hy3:warpcursor
    bind = , escape, submap, reset
    bind = $mod, A, submap, reset
    submap = reset

    bind = $mod, L, workspace, r+1
    bind = $mod, H, workspace, r-1
    bind = $mod, J, workspace, empty
    bind = $mod, Right, workspace, r+1
    bind = $mod, Left, workspace, r-1
    bind = $mod, Down, workspace, empty
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

    bind = Ctrl+Shift, Escape, exec, uwsm app -- btop.desktop

    bindd = $mod+Shift, P,Color Picker , exec, uwsm-app -- hyprpicker -a # Pick color (Hex) >> clipboard#

    bind = , XF86Calculator, exec, uwsm-app -- qalculate-gtk
  '';
}

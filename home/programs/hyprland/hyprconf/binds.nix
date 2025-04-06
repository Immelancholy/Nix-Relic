{
  wayland.windowManager.hyprland.settings = {
    bindl = [
    ];
    bind =
      [
        "$mod, R, hy3:changegroup, opposite"
        "$mod, D, hy3:makegroup, h"
        "$mod, S, hy3:makegroup, v"
        "$mod, Z, hy3:makegroup, tab"
        "$mod, T, exec, $term"
        ''$mods, T, exec, $term --class "tmux" tmux''
        "$mod, F, exec, $browser"
        "$mod, E, exec, $files"
        "$mod, grave, exec, $menu"
        "$mod, C, exec, $edit"
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
        ''$mod, V, exec, $term --class "NixDots" uwsm app -- tnix''
        "$mod, N, exec, uwsm-app -- cliphist.sh"
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
    bindel  = , mouse:281, exec, uwsm-app -- rmpc volume +1 # volume up
    bindel  = , mouse:282, exec, uwsm-app -- rmpc volume -1 # volume down
    bindl  = $mod, mouse:282, exec, $playerctl next #next
    bindl  = $mod, mouse:281, exec, $playerctl previous #previous,
    bindl = , F10, pass, class:^(com.obsproject.Studio)$
    bindl = , F12, pass, class:^(com.obsproject.Studio)$
    bindl = , F9, pass, class:^(com.obsproject.Studio)$
    bindl = Alt, F10, pass, class:^(com.obsproject.Studio)$
    bindn = , mouse:275, exec, pushToMuteVesktop
    bindnr = , mouse:275, exec, pushToMuteVesktop


    bind = $mods, P, submap, player
    submap = player
    bindl = , P, exec, $playerctl play-pause
    bindel  = , O, exec, uwsm-app -- rmpc volume +1 # volume up
    bindel  = , I, exec, uwsm-app -- rmpc volume -1 # volume down
    bindel  = Shift, O, exec, $playerctl next # next
    bindel  = Shift, I, exec, $playerctl previous # next
    bind = , escape, submap, reset
    bind = $mod, P, submap, reset
    submap = reset

    bind = $mod, A, submap, move
    submap = move
    bind = Alt, Return, fullscreen, 1
    bind = Alt+Shift, Return, fullscreen
    bind = , Q, hy3:warpcursor
    bind = , I, hy3:changefocus, raise
    bind = Shift, I, hy3:changefocus, lower
    bind = , W, togglefloating
    bind = , C, hy3:expand, expand
    bind = Shift, C, hy3:expand, base
    bind = , H, hy3:movefocus, l, once
    bind = , J, hy3:movefocus, d, once
    bind = , K, hy3:movefocus, u, once
    bind = , L, hy3:movefocus, r, once
    bind = , Left, hy3:movefocus, l, once
    bind = , Tab, hy3:togglefocuslayer
    bind = , Down, hy3:movefocus, d, once
    bind = , Up, hy3:movefocus, u, once
    bind = , Right, hy3:movefocus, r, once
    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow

    bind = $mod, Right, hy3:movetoworkspace, r+1, warp
    bind = $mod, Left, hy3:movetoworkspace, r-1, warp
    bind = $mod, Down, hy3:movetoworkspace, empty, warp
    bind = $mod, L, hy3:movetoworkspace, r+1, warp
    bind = $mod, H, hy3:movetoworkspace, r-1, warp
    bind = $mod, J, hy3:movetoworkspace, empty, warp
    bind = $mod, Right, workspace, r+1
    bind = $mod, Left, workspace, r-1
    bind = $mod, Down, workspace, empty
    bind = $mod, L, workspace, r+1
    bind = $mod, H, workspace, r-1
    bind = $mod, J, workspace, empty

    bind = Alt, H, hy3:movefocus, l, visible, nowarp
    bind = Alt, J, hy3:movefocus, d, visible, nowarp
    bind = Alt, K, hy3:movefocus, u, visible, nowarp
    bind = Alt, L, hy3:movefocus, r, visible, nowarp
    bind = Alt, Left, hy3:movefocus, l, visible, nowarp
    bind = Alt, Down, hy3:movefocus, d, visible, nowarp
    bind = Alt, Up, hy3:movefocus, u, visible, nowarp
    bind = Alt, Right, hy3:movefocus, r, visible, nowarp

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
    bind = , mouse_up, workspace, e+1
    bind = , mouse_down, workspace, e-1
    bind = $mod, mouse_up, workspace, r+1
    bind = $mod, mouse_down, workspace, r-1

    bind = , R, submap, resize
    submap = resize
    binde = , Left, resizeactive, 1 0
    binde = , Right, resizeactive, -1 0
    binde = , Up, resizeactive, 0 -1
    binde = , Down, resizeactive, 0 1
    binde = , H, resizeactive, 30 0
    binde = , L, resizeactive, -30 0
    binde = , K, resizeactive, 0 -30
    binde = , J, resizeactive, 0 30
    bind = , R, submap, move
    bind = , escape, submap, move
    submap = move

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
    bind = $mods, mouse_up, workspace, r+1
    bind = $mods, mouse_down, workspace, r-1

    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
    bindn = , mouse_down, hy3:focustab, r, require_hovered
    bindn = , mouse_up, hy3:focustab, l, require_hovered
    bind = $mod, Q, hy3:warpcursor
    bind = $mods, X, hy3:movetoworkspace, special
    bind = $mod, X, togglespecialworkspace,

    bind = , Print, exec, uwsm-app -- ss.sh o
    bind = Ctrl, Print, exec, uwsm-app -- ss.sh af
    bind = Ctrl+Shift, Print, exec, uwsm-app -- ss.sh w

    bind = $mod, P, submap, ss
    submap = ss
    bind = , O, exec, uwsm-app -- ss.sh o
    bind = , A, exec, uwsm-app -- ss.sh af
    bind = , W, exec, uwsm-app -- ss.sh w
    bind = , escape, submap, reset
    bind = , P, submap, reset
    submap = reset

    bind = Ctrl+Shift, Escape, exec, uwsm app -- $term --title "btop" btop

    bindd = $mod, O,Color Picker , exec, uwsm-app -- hyprpicker -a # Pick color (Hex) >> clipboard#

    bind = , XF86Calculator, exec, uwsm-app -- qalculate-gtk
  '';
}

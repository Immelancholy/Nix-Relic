{
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        "$mod, T, exec, $term"
        ''$mods, T, exec, $term --class "tmux" tmux''
        "$mod, F, exec, $browser"
        "$mod, E, exec, $files"
        "$mod, grave, exec, $menu"
        "$mod, C, exec, $edit"
        "Alt, Return, fullscreen, 1"
        "Alt+Shift, Return, fullscreen"
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] $term --class "rmpc" uwsm app -- rmpc.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 858 462; move 640 609] $term --class "cava" uwsm app -- cava.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 666; move 10 404] $term --class "btop" uwsm app -- btop.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 402 1030; move 1508 40] $term --class "neo" uwsm app -- neo.sh''
        ''$mods, U, exec, [workspace 1 silent; float; size 620 354; move 10 40] $term --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"''
        "$mod, Delete, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
        "$mod, 0, workspace, 10"
        "Ctrl+Alt, L, exec, uwsm-app -- swaylock -fF"
        ''$mod, V, exec, $term --class "NixDots" uwsm app -- tnix''
        "$mod, N, exec, uwsm-app -- cliphist.sh"
        "Alt+Shift, Tab, exec, rofi -show window -modi window"
        "$mod, M, exec, hyprgame"
        "$mod, L, workspace, r+1"
        "$mod, H, workspace, r-1"
        "$mod, J, workspace, empty"
        "$mod, Right, workspace, r+1"
        "$mod, Left, workspace, r-1"
        "$mod, Down, workspace, empty"
        "$mod, mouse_up, workspace, e+1"
        "$mod, mouse_down, workspace, e-1"
        "$mods, mouse_up, workspace, r+1"
        "$mods, mouse_down, workspace, r-1"
        ''Ctrl+Shift, Escape, exec, uwsm app -- $term --title "btop" btop''
        ", XF86Calculator, exec, uwsm-app -- qalculate-gtk"
        "$mod, X, togglespecialworkspace"
        ", Print, exec, uwsm-app -- ss.sh o"
        "Ctrl, Print, exec, uwsm-app -- ss.sh af"
        "Ctrl+Shift, Print, exec, uwsm-app -- ss.sh w"
        "$mod, O, exec, uwsm-app -- hyprpicker -a"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
            ]
          )
          9)
      );
    bindl = [
      ", XF86AudioMute, exec, $playerctl play-pause #pause-play media"
      "$mod, mouse:282, exec, $playerctl next" #next
      "$mod, mouse:281, exec, $playerctl previous" #previous,
      ", F10, pass, class:^(com.obsproject.Studio)$"
      ", F12, pass, class:^(com.obsproject.Studio)$"
      ", F9, pass, class:^(com.obsproject.Studio)$"
      "Alt, F10, pass, class:^(com.obsproject.Studio)$"
      ", mouse:277, exec, $playerctl play-pause" # toggle between media play and pause
    ];
    bindel = [
      ", XF86AudioLowerVolume, exec, uwsm-app -- rmpc volume -1" # decrease volume
      ", XF86AudioRaiseVolume, exec, uwsm-app -- rmpc volume +1" # increase volume
      ", mouse:281, exec, uwsm-app -- rmpc volume +1" # volume up
      ", mouse:282, exec, uwsm-app -- rmpc volume -1" # volume down
    ];
    bindn = [
      ", mouse:275, exec, pushToMuteChromium"
    ];
    bindnr = [
      ", mouse:275, exec, pushToMuteChromium"
    ];
  };
  wayland.windowManager.hyprland.extraConfig = ''
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

    bind = $mod, P, submap, ss
    submap = ss
    bind = , O, exec, uwsm-app -- ss.sh o
    bind = , A, exec, uwsm-app -- ss.sh af
    bind = , W, exec, uwsm-app -- ss.sh w
    bind = , escape, submap, reset
    bind = , P, submap, reset
    submap = reset
  '';
}

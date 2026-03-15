{
  config,
  pkgs,
  ...
}: let
  playerCmd = config.player.cmd;
  playerClass = config.player.class;
  launches = pkgs.writeShellScriptBin "launches" ''
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(${playerClass}),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(neo),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(fastfetch),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(btop),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(cava),9'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 888 462; move 610 609] uwsm app -- kitty --class "cava" cava.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 590 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- kitty --class "neo" neo.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 590 383; move 10 42] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 888 559; move 610 42] ${playerCmd}'
  '';
in {
  home.packages = [
    launches
  ];
  wayland.windowManager.hyprland = {
    submaps = {
      player.settings = {
        bind = [
          ", escape, submap, reset"
          "$mod, P, submap, reset"
        ];
        bindl = [
          ", P, exec, $playerctl play-pause"
        ];
        bindel = [
          ", O, exec, uwsm-app -- playerVol inc"
          ", I, exec, uwsm-app -- playerVol dec"
          "Shift, O, exec, $playerctl next"
          "Shift, I, exec, $playerctl previous"
        ];
      };
    };
    settings = {
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        [
          "$mod, B, exec, binds.sh"
          "$mod, W, togglefloating"
          ", Pause, exec, $playerctl play-pause"
          "$mod, T, exec, $term"
          ''$mods, T, exec, $term --class "tmux" tmux''
          "$mod, F, exec, $browser"
          "$mod, E, exec, $files"
          "$mod, grave, exec, $menu"
          "Alt, Return, fullscreen"
          "Alt+Shift, Return, fullscreen, 1"
          "$mod, Tab, exec, rofi -show window -modi window"
          "$mods, U, exec, launches"
          "$mod, Delete, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
          "$mod, 0, workspace, 10"
          "Ctrl+Shift, L, exec, uwsm-app -- swaylock -fF"
          "$mod, N, exec, rofi -show Cliphist -modi Cliphist:cliphist.sh"
          "Ctrl, Period, exec, rofi -show emoji nerdy -modi emoji,nerdy"
          "$mod, G, exec, hyprgame"
          "$mod, Right, workspace, r+1"
          "$mod, Left, workspace, r-1"
          "$mod, Down, workspace, empty"
          ''Ctrl+Shift, Escape, exec, uwsm app -- $term --title "btop" btop''
          ", XF86Calculator, exec, uwsm-app -- qalculate-gtk"
          "$mod, X, togglespecialworkspace"
          ", Print, exec, hyprquickshot"
          "$mod, O, exec, uwsm-app -- hyprpicker -a"
          "$mods, P, submap, player"
          "$mod, comma, movecurrentworkspacetomonitor, l"
          "$mod, period, movecurrentworkspacetomonitor, r"
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
        ", XF86AudioPlay, exec, $playerctl play-pause #pause-play media"
        ", XF86AudioNext, exec, $playerctl next" #next
        ", XF86AudioPrev, exec, $playerctl previous" #previous,
        ", XF86AudioMute, exec, uwsm-app -- playerVol mute" # decrease volume of mpd
      ];
      bindel = [
        ", XF86AudioLowerVolume, exec, uwsm-app -- playerVol dec" # decrease volume of mpd
        ", XF86AudioRaiseVolume, exec, uwsm-app -- playerVol inc" # increase volume of mpd
        "Shift, XF86AudioLowerVolume, exec, uwsm-app -- playerVol dec-mini" # decrease volume of mpd
        "Shift, XF86AudioRaiseVolume, exec, uwsm-app -- playerVol inc-mini" # increase volume of mpd
        ", XF86MonBrightnessUp, exec, brightness inc"
        ", XF86MonBrightnessDown, exec, brightness dec"
      ];
    };
  };
}

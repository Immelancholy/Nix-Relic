{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    useHy3 = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hy3 tyling style'';
    };
  };
  config = mkMerge [
    (mkIf cfg.useHy3 {
      wayland.windowManager.hyprland = {
        plugins = [
          inputs.hy3.packages.${pkgs.system}.hy3
        ];
        settings = {
          general = {
            layout = mkForce "hy3";
          };
          plugin = {
            hy3 = {
              tabs = {
                radius = 10;
                padding = 4;
                text_font = "JetBrainsMono Nerd Font Mono Bold"; # default: Sans
                text_height = 9;
                border_width = 2;
                "col.active" = "rgba(1e1e2eB5)";
                "col.active.border" = "rgba(cba6f7ff)";
                "col.active.text" = "rgba(cdd6f4ff)";
                "col.focused" = "rgba(1e1e2eB5)";
                "col.focused.border" = "rgba(6c7086cc)";
                "col.focused.text" = "rgba(7f849cff)";
                "col.inactive" = "rgba(1e1e2eB5)";
                "col.inactive.border" = "rgba(b4befecc)";
                "col.inactive.text" = "rgba(cdd6f4ff)";
                "col.urgent" = "rgba(1e1e2eB5)";
                "col.urgent.border" = "rgba(f9e2afff)";
                "col.urgent.text" = "rgba(cdd6f4ff)";
              };
              # no_gaps_when_only = 1
              group_inset = 4;
              autotile = {
                enable = true;
                ephemeral_groups = false;
                trigger_width = 640;
                trigger_height = 340;
              };
            };
          };
          bind =
            [
              "$mod, R, hy3:changegroup, opposite"
              "$mod, D, hy3:makegroup, h"
              "$mod, S, hy3:makegroup, v"
              "$mod, Z, hy3:makegroup, tab"
              "$mods, 0, hy3:movetoworkspace, 10"
              "$mod+Ctrl, 0, hy3:focustab, index, 10"
              "$mods, Q, hy3:killactive"
              "$mod, Q, hy3:warpcursor"
              "$mods, X, hy3:movetoworkspace, special"
              "$mod, Tab, hy3:togglefocuslayer"
              "$mod, W, togglefloating"
            ]
            ++ (
              # workspaces
              # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
              builtins.concatLists (builtins.genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mods, code:1${toString i}, hy3:movetoworkspace, ${toString ws}"
                    "$mod+Ctrl, code:1${toString i}, hy3:focustab, index, 0${toString ws}"
                  ]
                )
                9)
            );
          bindn = [
            ", mouse_down, hy3:focustab, r, require_hovered"
            ", mouse_up, hy3:focustab, l, require_hovered"
          ];
        };
        extraConfig = ''

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
        '';
      };
    })
    (mkIf (!cfg.useHy3) {
      wayland.windowManager.hyprland = {
        settings = {
          general = {
            layout = "dwindle";
          };
          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };
          bind =
            [
              "$mod, R, togglegroup"
              "$mods, 0, movetoworkspacesilent, 10"
              "$mod+Ctrl, 0, changegroupactive, index, 10"
              "$mods, Q, killactive"
              "$mods, X, movetoworkspacesilent, special"
            ]
            ++ (
              # workspaces
              # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
              builtins.concatLists (builtins.genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mods, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
                    "$mod+Ctrl, code:1${toString i}, changegroupactive, index, 0${toString ws}"
                  ]
                )
                9)
            );
        };
        extraConfig = ''
          bind = $mod, A, submap, move
          submap = move
          bind = Alt, Return, fullscreen, 1
          bind = Alt+Shift, Return, fullscreen
          bind = , W, togglefloating
          bind = , H, movefocus, l
          bind = , J, movefocus, d
          bind = , K, movefocus, u
          bind = , L, movefocus, r
          bind = , Left, movefocus, l
          bind = , Down, movefocus, d
          bind = , Up, movefocus, u
          bind = , Right, movefocus, r
          bindm = $mod, mouse:272, movewindow
          bindm = $mod, mouse:273, resizewindow

          bind = $mod, Right, movetoworkspace, r+1
          bind = $mod, Left, movetoworkspace, r-1
          bind = $mod, Down, movetoworkspace, empty
          bind = $mod, L, movetoworkspace, r+1
          bind = $mod, H, movetoworkspace, r-1
          bind = $mod, J, movetoworkspace, empty
          bind = $mod, Right, workspace, r+1
          bind = $mod, Left, workspace, r-1
          bind = $mod, Down, workspace, empty
          bind = $mod, L, workspace, r+1
          bind = $mod, H, workspace, r-1
          bind = $mod, J, workspace, empty

          bind = Shift, H, movewindow, l
          bind = Shift, J, movewindow, d
          bind = Shift, K, movewindow, u
          bind = Shift, L, movewindow, r
          bind = Shift, Right, movewindow, r
          bind = Shift, Down, movewindow, d
          bind = Shift, Up, movewindow, u
          bind = Shift, Left, movewindow, l
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
        '';
      };
    })
  ];
}

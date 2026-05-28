{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland.layout.scrolling;
in {
  options.wayland.windowManager.hyprland.layout.scrolling = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hyprland scrolling layout'';
    };
  };
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        general = {
          layout = "scrolling";
        };
        bind =
          [
            "$mod, Z, togglegroup"
            "$mods, 0, movetoworkspacesilent, 10"
            "$mods, Q, killactive"
            "$mods, S, movetoworkspacesilent, special"
            "$mod, H, layoutmsg, move -col"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, layoutmsg, move +col"
            "$mod, V, layoutmsg, fit visible"
            "$mod, U, layoutmsg, fit active"
            "$mod, R, layoutmsg, colresize 0.5"
            "$mods, L, workspace, r+1"
            "$mods, H, workspace, r-1"
            "$mods, J, workspace, empty"
            "$mod, Right, layoutmsg, move +col"
            "$mod, Down, movefocus, d"
            "$mod, Up, movefocus, u"
            "$mod, Left, layoutmsg, move -col"
            "$mods, Right, workspace, r+1"
            "$mods, Left, workspace, r-1"
            "$mods, Down, workspace, empty"
            "$mod, mouse_up, layoutmsg, focus right"
            "$mod, mouse_down, layoutmsg, focus left"
            "$mods, mouse_up, workspace, e-1"
            "$mods, mouse_down, workspace, e+1"
            "$modc, H, changegroupactive, b"
            "$modc, L, changegroupactive, f"
            "$modc, Right, changegroupactive, b"
            "$modc, Left, changegroupactive, f"
            "$mod, Y, fullscreen, 1"
            "$mod, C, layoutmsg, colresize +conf"
            "$mods, C, layoutmsg, colresize -conf"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mods, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
                ]
              )
              9)
          );
      };
      extraConfig = ''
        bind = $mod, A, submap, manage
        submap = manage
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , W, togglefloating
        bind = , P, layoutmsg, promote
        bind = , O, pin, active
        bind = , Y, fullscreen, 1
        bind = , H, layoutmsg, move -col
        bind = , J, movefocus, d
        bind = , K, movefocus, u
        bind = , L, layoutmsg, move +col
        bind = , Left, layoutmsg, move +col
        bind = , Down, movefocus, d
        bind = , Up, movefocus, u
        bind = , Right, layoutmsg, move -col
        bind = , C, layoutmsg, colresize +conf
        bind = Shift, C, layoutmsg, colresize -conf
        bind = , V, layoutmsg, fit visible
        bind = , U, layoutmsg, fit active
        bind = , R, layoutmsg, colresize 0.5
        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow

        bind = $mod, Right, movetoworkspace, r+1
        bind = $mod, Left, movetoworkspace, r-1
        bind = $mod, Down, movetoworkspace, empty
        bind = $mod, L, movetoworkspace, r+1
        bind = $mod, H, movetoworkspace, r-1
        bind = $mod, J, movetoworkspace, empty

        bind = Ctrl, H, changegroupactive, b
        bind = Ctrl, L, changegroupactive, f
        bind = Ctrl, Right, changegroupactive, b
        bind = Ctrl, Left, changegroupactive, f

        bind = $mods, H, movewindow, l
        bind = $mods, J, movewindow, d
        bind = $mods, K, movewindow, u
        bind = $mods, L, movewindow, r
        bind = $mods, Left, movewindow, l
        bind = $mods, Down, movewindow, d
        bind = $mods, Up, movewindow, u
        bind = $mods, Right, movewindow, r
        bind = Shift, H, layoutmsg, swapcol l
        bind = Shift, L, layoutmsg, swapcol r
        bind = Shift, Right, layoutmsg, swapcol r
        bind = Shift, Left, layoutmsg, swapcol l
        bind = , mouse_up, layoutmsg, focus right
        bind = , mouse_down, layoutmsg, focus left
        bind = $mod, mouse_up, workspace, e-1
        bind = $mod, mouse_down, workspace, e+1

        bind = $mods, R, submap, resize
        submap = resize
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , Y , fullscreen, 1
        bind = , C , layoutmsg, colresize +conf
        bind = , W, togglefloating
        bind = , C, layoutmsg, colresize +conf
        bind = Shift, C, layoutmsg, colresize -conf
        bind = , V, layoutmsg, fit visible
        bind = , U, layoutmsg, fit active
        bind = , R, layoutmsg, colresize 0.5
        binde = , Right, resizeactive, 30 0
        binde = , Left, resizeactive, 30 0
        binde = , Left, moveactive, -30 0
        binde = , Up, resizeactive, 0 30
        binde = , Up, moveactive, 0 -30
        binde = , Down, resizeactive, 0 30

        binde = , L, resizeactive, 30 0
        binde = , H, resizeactive, 30 0
        binde = , H, moveactive, -30 0
        binde = , K, resizeactive, 0 30
        binde = , K, moveactive, 0 -30
        binde = , J, resizeactive, 0 30

        binde = Shift, Right, resizeactive, -30 0
        binde = Shift, Right, moveactive, 30 0
        binde = Shift, Left, resizeactive, -30 0
        binde = Shift, Up, resizeactive, 0 -30
        binde = Shift, Down, resizeactive, 0 -30
        binde = Shift, Down, moveactive, 0 30

        binde = Shift, L, resizeactive, -30 0
        binde = Shift, L, moveactive, 30 0
        binde = Shift, H, resizeactive, -30 0
        binde = Shift, K, resizeactive, 0 -30
        binde = Shift, J, resizeactive, 0 -30
        binde = Shift, J, moveactive, 0 30
        bind = $mod, R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = $mod, R, submap, resizeTiled
        submap = resizeTiled
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , Y, fullscreen, 1
        bind = , C, layoutmsg, colresize +conf
        bind = Shift, C, layoutmsg, colresize -conf
        bind = , V, layoutmsg, fit visible
        bind = , U, layoutmsg, fit active
        bind = , R, layoutmsg, colresize 0.5
        bind = , W, togglefloating
        binde = , Left, layoutmsg, colresize +0.1
        binde = , Right, layoutmsg, colresize -0.1
        binde = , H, layoutmsg, colresize +0.1
        binde = , L, layoutmsg, colresize -0.1
        bind = $mod, R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , M, submap, move
        submap = move
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , Y, fullscreen, 1
        bind = , C, layoutmsg, colresize +conf
        bind = Shift, C, layoutmsg, colresize -conf
        bind = , V, layoutmsg, fit visible
        bind = , U, layoutmsg, fit active
        bind = , R, layoutmsg, colresize 0.5
        bind = , W, togglefloating
        binde = , Left, moveactive, 10 0
        binde = , Right, moveactive, -10 0
        binde = , Up, moveactive, 0 -10
        binde = , Down, moveactive, 0 10
        binde = , H, moveactive, 30 0
        binde = , L, moveactive, -30 0
        binde = , K, moveactive, 0 -30
        binde = , J, moveactive, 0 30
        bind = $mod, M, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , escape, submap, reset

        bind = $mod, A, submap, reset
        submap = reset
      '';
    };
  };
}

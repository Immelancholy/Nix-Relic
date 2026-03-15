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
            "$mods, X, movetoworkspacesilent, special"
            "$mod, L, layoutmsg, move +col"
            "$mod, H, layoutmsg, move -col"
            "$mods, L, workspace, r+1"
            "$mods, H, workspace, r-1"
            "$mod, D, layoutmsg, promote"
            "$mod, mouse_up, layoutmsg, move +col"
            "$mod, mouse_down, layoutmsg, move -col"
            "$mods, mouse_up, workspace, r+1"
            "$mods, mouse_down, workspace, r-1"
            "$modc, H, changegroupactive, b"
            "$modc, L, changegroupactive, f"
            "$modc, Right, changegroupactive, b"
            "$modc, Left, changegroupactive, f"
            "$mod, Y, fullscreen, 1"
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
        bind = , P, pin, active
        bind = , Y, fullscreen, 1
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
        bind = $mods, Right, movewindow, r
        bind = $mods, Down, movewindow, d
        bind = $mods, Up, movewindow, u
        bind = $mods, Left, movewindow, l
        bind = Shift, H, layoutmsg, swapcol l
        bind = Shift, L, layoutmsg, swapcol r
        bind = Shift, Right, layoutmsg, swapcol r
        bind = Shift, Left, layoutmsg, swapcol l
        bind = , mouse_up, layoutmsg, move +col
        bind = , mouse_down, layoutmsg, move _col

        bind = Shift, R, submap, resize
        submap = resize
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , W, togglefloating
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
        bind = , R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , R, submap, resizeTiled
        submap = resizeTiled
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , W, togglefloating
        binde = , Left, layoutmsg, colresize +0.1
        binde = , Right, layoutmsg, colresize -0.1
        binde = , H, layoutmsg, colresize +0.1
        binde = , L, layoutmsg, colresize -0.1
        bind = , R, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , M, submap, move
        submap = move
        bind = Alt, Return, fullscreen, 1
        bind = Alt+Shift, Return, fullscreen
        bind = , W, togglefloating
        binde = , Left, moveactive, 10 0
        binde = , Right, moveactive, -10 0
        binde = , Up, moveactive, 0 -10
        binde = , Down, moveactive, 0 10
        binde = , H, moveactive, 30 0
        binde = , L, moveactive, -30 0
        binde = , K, moveactive, 0 -30
        binde = , J, moveactive, 0 30
        bind = , M, submap, manage
        bind = , escape, submap, manage
        submap = manage

        bind = , escape, submap, reset

        bind = $mod, A, submap, reset
        submap = reset
      '';
    };
  };
}

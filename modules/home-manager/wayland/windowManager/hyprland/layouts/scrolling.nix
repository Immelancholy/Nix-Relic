{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland.layout.scrolling;
  inherit (lib.generators) mkLuaInLine;
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
        bind = [
          {
            _args = [
              (mkLuaInLine "mod .. \" + Z\"")
              (mkLuaInLine "hl.dsp.groups.toggle()")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Q\"")
              (mkLuaInLine "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + R\"")
              (mkLuaInLine "hl.dsp.layout(\"colresize 0.5\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + H\"")
              (mkLuaInLine "hl.dsp.layout(\"move -col\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + J\"")
              (mkLuaInLine "hl.dsp.focus({direction = \"down\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + K\"")
              (mkLuaInLine "hl.dsp.focus({direction = \"up\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + L\"")
              (mkLuaInLine "hl.dsp.layout(\"move +col\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + H\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"r-1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + L\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"r+1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + J\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"empty\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Left\"")
              (mkLuaInLine "hl.dsp.layout(\"move -col\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Down\"")
              (mkLuaInLine "hl.dsp.focus({direction = \"down\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Up\"")
              (mkLuaInLine "hl.dsp.focus({direction = \"up\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Right\"")
              (mkLuaInLine "hl.dsp.layout(\"move +col\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + Left\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"r-1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + Right\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"r+1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + Down\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"empty\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + mouse_up\"")
              (mkLuaInLine "hl.dsp.layout(\"focus left\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + mouse_down\"")
              (mkLuaInLine "hl.dsp.layout(\"focus right\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + mouse_up\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"e-1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + mouse_down\"")
              (mkLuaInLine "hl.dsp.focus({workspace = \"e+1\"})")
            ];
          }
          {
            _args = [
              (mkLuaInLine "modc .. \" + H\"")
              (mkLuaInLine "hl.dsp.group.prev())")
            ];
          }
          {
            _args = [
              (mkLuaInLine "modc .. \" + L\"")
              (mkLuaInLine "hl.dsp.group.next())")
            ];
          }
          {
            _args = [
              (mkLuaInLine "modc .. \" + Left\"")
              (mkLuaInLine "hl.dsp.group.prev())")
            ];
          }
          {
            _args = [
              (mkLuaInLine "modc .. \" + Right\"")
              (mkLuaInLine "hl.dsp.group.next())")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + Y\"")
              (mkLuaInLine "hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" }))")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + C\"")
              (mkLuaInLine "hl.dsp.layout(\"colresize +conf\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mods .. \" + C\"")
              (mkLuaInLine "hl.dsp.layout(\"colresize -conf\")")
            ];
          }
        ];
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
        bind = , mouse_up, layoutmsg, focus left
        bind = , mouse_down, layoutmsg, focus right
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

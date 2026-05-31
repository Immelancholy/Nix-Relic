{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland.layout.scrolling;
  inherit (lib.generators) mkLuaInline;
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
      extraConfig =
        /*
        Lua
        */
        ''
          hl.config({
            general = {
              layout = "scrolling"
            }
          })
        '';
      settings = {
        #   bind = [
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Z\"")
        #         (mkLuaInline "hl.dsp.groups.toggle()")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Q\"")
        #         (mkLuaInline "hl.dsp.window.close()")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + R\"")
        #         (mkLuaInline "hl.dsp.layout(\"colresize 0.5\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + H\"")
        #         (mkLuaInline "hl.dsp.layout(\"move -col\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + J\"")
        #         (mkLuaInline "hl.dsp.focus({direction = \"down\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + K\"")
        #         (mkLuaInline "hl.dsp.focus({direction = \"up\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + L\"")
        #         (mkLuaInline "hl.dsp.layout(\"move +col\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + H\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"r-1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + L\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"r+1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + J\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"empty\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Left\"")
        #         (mkLuaInline "hl.dsp.layout(\"move -col\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Down\"")
        #         (mkLuaInline "hl.dsp.focus({direction = \"down\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Up\"")
        #         (mkLuaInline "hl.dsp.focus({direction = \"up\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Right\"")
        #         (mkLuaInline "hl.dsp.layout(\"move +col\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + Left\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"r-1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + Right\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"r+1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + Down\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"empty\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + mouse_up\"")
        #         (mkLuaInline "hl.dsp.layout(\"focus left\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + mouse_down\"")
        #         (mkLuaInline "hl.dsp.layout(\"focus right\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + mouse_up\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"e-1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + mouse_down\"")
        #         (mkLuaInline "hl.dsp.focus({workspace = \"e+1\"})")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "modc .. \" + H\"")
        #         (mkLuaInline "hl.dsp.group.prev())")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "modc .. \" + L\"")
        #         (mkLuaInline "hl.dsp.group.next())")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "modc .. \" + Left\"")
        #         (mkLuaInline "hl.dsp.group.prev())")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "modc .. \" + Right\"")
        #         (mkLuaInline "hl.dsp.group.next())")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + Y\"")
        #         (mkLuaInline "hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" }))")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mod .. \" + C\"")
        #         (mkLuaInline "hl.dsp.layout(\"colresize +conf\")")
        #       ];
        #     }
        #     {
        #       _args = [
        #         (mkLuaInline "mods .. \" + C\"")
        #         (mkLuaInline "hl.dsp.layout(\"colresize -conf\")")
        #       ];
        #     }
        #   ];
        # };
        # extraConfig = /* Lua */ ''
        #   hl.bind(mod .." + A", hl.dsp.submap("manage"))
        #   hl.define_submap("manage", function()
        #     hl.bind("Alt + Return", hl.dps.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
        #     hl.bind("Alt + Shift + Return", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
        #     hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
        #     hl.bind("P", hl.dsp.layout(promote)),
        #     hl.bind("O", hl.dsp.window(pin)),
        #     hl.bind("Y", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
        #     hl.bind("H", hl.dsp.layout("move -col")),
        #     hl.bind = , J, movefocus, d
        #     hl.bind = , K, movefocus, u
        #     hl.bind = , L, layoutmsg, move +col
        #     hl.bind = , Left, layoutmsg, move +col
        #     hl.bind = , Down, movefocus, d
        #     hl.bind = , Up, movefocus, u
        #     hl.bind = , Right, layoutmsg, move -col
        #     hl.bind = , C, layoutmsg, colresize +conf
        #     hl.bind = Shift, C, layoutmsg, colresize -conf
        #     hl.bind = , V, layoutmsg, fit visible
        #     hl.bind = , U, layoutmsg, fit active
        #     hl.bind = , R, layoutmsg, colresize 0.5
        #     hl.bindm = $mod, mouse:272, movewindow
        #     hl.bindm = $mod, mouse:273, resizewindow
        #   end)
        #
        #   bind = $mod, Left, movetoworkspace, r-1
        #   bind = $mod, Down, movetoworkspace, empty
        #   bind = $mod, L, movetoworkspace, r+1
        #   bind = $mod, H, movetoworkspace, r-1
        #   bind = $mod, J, movetoworkspace, empty
        #
        #   bind = Ctrl, H, changegroupactive, b
        #   bind = Ctrl, L, changegroupactive, f
        #   bind = Ctrl, Right, changegroupactive, b
        #   bind = Ctrl, Left, changegroupactive, f
        #
        #   bind = $mods, H, movewindow, l
        #   bind = $mods, J, movewindow, d
        #   bind = $mods, K, movewindow, u
        #   bind = $mods, L, movewindow, r
        #   bind = $mods, Left, movewindow, l
        #   bind = $mods, Down, movewindow, d
        #   bind = $mods, Up, movewindow, u
        #   bind = $mods, Right, movewindow, r
        #   bind = Shift, H, layoutmsg, swapcol l
        #   bind = Shift, L, layoutmsg, swapcol r
        #   bind = Shift, Right, layoutmsg, swapcol r
        #   bind = Shift, Left, layoutmsg, swapcol l
        #   bind = , mouse_up, layoutmsg, focus left
        #   bind = , mouse_down, layoutmsg, focus right
        #   bind = $mod, mouse_up, workspace, e-1
        #   bind = $mod, mouse_down, workspace, e+1
        #
        #   bind = $mods, R, submap, resize
        #   submap = resize
        #   bind = Alt, Return, fullscreen, 1
        #   bind = Alt+Shift, Return, fullscreen
        #   bind = , Y , fullscreen, 1
        #   bind = , C , layoutmsg, colresize +conf
        #   bind = , W, togglefloating
        #   bind = , C, layoutmsg, colresize +conf
        #   bind = Shift, C, layoutmsg, colresize -conf
        #   bind = , V, layoutmsg, fit visible
        #   bind = , U, layoutmsg, fit active
        #   bind = , R, layoutmsg, colresize 0.5
        #   binde = , Right, resizeactive, 30 0
        #   binde = , Left, resizeactive, 30 0
        #   binde = , Left, moveactive, -30 0
        #   binde = , Up, resizeactive, 0 30
        #   binde = , Up, moveactive, 0 -30
        #   binde = , Down, resizeactive, 0 30
        #
        #   binde = , L, resizeactive, 30 0
        #   binde = , H, resizeactive, 30 0
        #   binde = , H, moveactive, -30 0
        #   binde = , K, resizeactive, 0 30
        #   binde = , K, moveactive, 0 -30
        #   binde = , J, resizeactive, 0 30
        #
        #   binde = Shift, Right, resizeactive, -30 0
        #   binde = Shift, Right, moveactive, 30 0
        #   binde = Shift, Left, resizeactive, -30 0
        #   binde = Shift, Up, resizeactive, 0 -30
        #   binde = Shift, Down, resizeactive, 0 -30
        #   binde = Shift, Down, moveactive, 0 30
        #
        #   binde = Shift, L, resizeactive, -30 0
        #   binde = Shift, L, moveactive, 30 0
        #   binde = Shift, H, resizeactive, -30 0
        #   binde = Shift, K, resizeactive, 0 -30
        #   binde = Shift, J, resizeactive, 0 -30
        #   binde = Shift, J, moveactive, 0 30
        #   bind = $mod, R, submap, manage
        #   bind = , escape, submap, manage
        #   submap = manage
        #
        #   bind = $mod, R, submap, resizeTiled
        #   submap = resizeTiled
        #   bind = Alt, Return, fullscreen, 1
        #   bind = Alt+Shift, Return, fullscreen
        #   bind = , Y, fullscreen, 1
        #   bind = , C, layoutmsg, colresize +conf
        #   bind = Shift, C, layoutmsg, colresize -conf
        #   bind = , V, layoutmsg, fit visible
        #   bind = , U, layoutmsg, fit active
        #   bind = , R, layoutmsg, colresize 0.5
        #   bind = , W, togglefloating
        #   binde = , Left, layoutmsg, colresize +0.1
        #   binde = , Right, layoutmsg, colresize -0.1
        #   binde = , H, layoutmsg, colresize +0.1
        #   binde = , L, layoutmsg, colresize -0.1
        #   bind = $mod, R, submap, manage
        #   bind = , escape, submap, manage
        #   submap = manage
        #
        #   bind = , M, submap, move
        #   submap = move
        #   bind = Alt, Return, fullscreen, 1
        #   bind = Alt+Shift, Return, fullscreen
        #   bind = , Y, fullscreen, 1
        #   bind = , C, layoutmsg, colresize +conf
        #   bind = Shift, C, layoutmsg, colresize -conf
        #   bind = , V, layoutmsg, fit visible
        #   bind = , U, layoutmsg, fit active
        #   bind = , R, layoutmsg, colresize 0.5
        #   bind = , W, togglefloating
        #   binde = , Left, moveactive, 10 0
        #   binde = , Right, moveactive, -10 0
        #   binde = , Up, moveactive, 0 -10
        #   binde = , Down, moveactive, 0 10
        #   binde = , H, moveactive, 30 0
        #   binde = , L, moveactive, -30 0
        #   binde = , K, moveactive, 0 -30
        #   binde = , J, moveactive, 0 30
        #   bind = $mod, M, submap, manage
        #   bind = , escape, submap, manage
        #   submap = manage
        #
        #   bind = , escape, submap, reset
        #
        #   bind = $mod, A, submap, reset
        #   submap = reset
        # '';
      };
    };
  };
}

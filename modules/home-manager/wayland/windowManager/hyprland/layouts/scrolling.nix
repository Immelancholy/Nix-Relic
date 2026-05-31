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
          hl.bind(mod .. " + Z", hl.dsp.groups.toggle())
          hl.bind(mod .. " + Q", hl.dsp.window.close())
          hl.bind(mod .. " + R", hl.dsp.layout("colresize 0.5"))
          hl.bind(mod .. " + H", hl.dsp.layout("move -col"))
          hl.bind(mod .. " + J", hl.dsp.focus({direction = "down"}))
          hl.bind(mod .. " + K", hl.dsp.focus({direction = "up"}))
          hl.bind(mod .. " + L", hl.dsp.layout("move +col"))
          hl.bind(mod .. " + Left", hl.dsp.layout("move -col"))
          hl.bind(mod .. " + Down", hl.dsp.focus({direction = "down"}))
          hl.bind(mod .. " + Up", hl.dsp.focus({direction = "up"}))
          hl.bind(mod .. " + Right", hl.dsp.layout("move +col"))
          hl.bind(mods .. " + H", hl.dsp.focus({workspace = "r-1"}))
          hl.bind(mods .. " + L", hl.dsp.focus({workspace = "r+1"}))
          hl.bind(mods .. " + J", hl.dsp.focus({workspace = "empty"}))
          hl.bind(mods .. " + Left", hl.dsp.focus({workspace = "r-1"}))
          hl.bind(mods .. " + Right", hl.dsp.focus({workspace = "r+1"}))
          hl.bind(mods .. " + Down", hl.dsp.focus({workspace = "empty"}))
          hl.bind(mod .. " + mouse_up", hl.dsp.layout("focus left"))
          hl.bind(mod .. " + mouse_down", hl.dsp.layout("focus right"))
          hl.bind(mods .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}))
          hl.bind(mods .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}))
          hl.bind(modc .. " + H", hl.dsp.group.prev())
          hl.bind(modc .. " + L", hl.dsp.group.next())
          hl.bind(modc .. " + Left", hl.dsp.group.prev())
          hl.bind(modc .. " + Right", hl.dsp.group.next())
          hl.bind(mod .. " + Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
          hl.bind(mod .. " + C", hl.dsp.layout("colresize +conf"))
          hl.bind(mods .. " + C", hl.dsp.layout("colresize -conf"))
              
          hl.bind(mod .." + A", hl.dsp.submap("manage"))
          hl.define_submap("manage", function()
            hl.bind("Alt + Return", hl.dps.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
            hl.bind("Alt + Shift + Return", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
            hl.bind("P", hl.dsp.layout(promote)),
            hl.bind("O", hl.dsp.window(pin)),
            hl.bind("Y", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            hl.bind("H", hl.dsp.layout("move -col")),
            hl.bind("J", hl.dsp.focus({direction = "down"})),
            hl.bind("K", hl.dsp.focus({direction = "up"})),
            hl.bind("L", hl.dsp.layout("move +col")),
            hl.bind("Left", hl.dsp.layout("move -col")),
            hl.bind("Down", hl.dsp.focus({direction = "down"})),
            hl.bind("Up", hl.dsp.focus({direction = "up"})),
            hl.bind("Right", hl.dsp.layout("move +col")),
            hl.bind("C", hl.dsp.layout("colresize +conf")),
            hl.bind("Shift + C", hl.dsp.layout("colresize -conf")),
            hl.bind("R", hl.dsp.layout("colresize 0.5")),
            hl.bindm(mod .. " + mouse:272", hl.dsp.window.drag()),
            hl.bindm(mod .. " + mouse:273", hl.dsp.window.resize()),

            hl.bind(mod .. " + H", hl.dsp.focus({workspace = "r-1"})),
            hl.bind(mod .. " + L", hl.dsp.focus({workspace = "r+1"})),
            hl.bind(mod .. " + J", hl.dsp.focus({workspace = "empty"})),
            hl.bind(mod .. " + Left", hl.dsp.focus({workspace = "r-1"})),
            hl.bind(mod .. " + Right", hl.dsp.focus({workspace = "r+1"})),
            hl.bind(mod .. " + Down", hl.dsp.focus({workspace = "empty"})),

            hl.bind("Ctrl + H", hl.dsp.group.prev()),
            hl.bind("Ctrl + L", hl.dsp.group.next()),
            hl.bind("Ctrl + Left", hl.dsp.group.prev()),
            hl.bind("Ctrl + Right", hl.dsp.group.next()),

            hl.bind(mods .. " + H", hl.dsp.window.move({direction = "left"})),
            hl.bind(mods .. " + J", hl.dsp.window.move({direction = "down"})),
            hl.bind(mods .. " + K", hl.dsp.window.move({direction = "up"})),
            hl.bind(mods .. " + L", hl.dsp.window.move({direction = "right"})),
            hl.bind(mods .. " + Left", hl.dsp.window.move({direction = "left"})),
            hl.bind(mods .. " + Down", hl.dsp.window.move({direction = "down"})),
            hl.bind(mods .. " + Up", hl.dsp.window.move({direction = "up"})),
            hl.bind(mods .. " + Right", hl.dsp.window.move({direction = "right"})),

            hl.bind(modc .. " + Shift + H", hl.dsp.window.move({direction = "left", group_aware = true })),
            hl.bind(modc .. " + Shift + J", hl.dsp.window.move({direction = "down", group_aware = true })),
            hl.bind(modc .. " + Shift + K", hl.dsp.window.move({direction = "up", group_aware = true })),
            hl.bind(modc .. " + Shift + L", hl.dsp.window.move({direction = "right", group_aware = true })),
            hl.bind(modc .. " + Shift + Left", hl.dsp.window.move({direction = "left", group_aware = true })),
            hl.bind(modc .. " + Shift + Down", hl.dsp.window.move({direction = "down", group_aware = true })),
            hl.bind(modc .. " + Shift + Up", hl.dsp.window.move({direction = "up", group_aware = true })),
            hl.bind(modc .. " + Shift + Right", hl.dsp.window.move({direction = "right", group_aware = true })),

            hl.bind("Shift + H", hl.dsp.layout("swapcol l")),
            hl.bind("Shift + L", hl.dsp.layout("swapcol r")),
            hl.bind("Shift + Left", hl.dsp.layout("swapcol l")),
            hl.bind("Shift + Right", hl.dsp.layout("swapcol r")),
            hl.bind("mouse_up", hl.dsp.layout("focus left")),
            hl.bind("mouse_down", hl.dsp.layout("focus right")),
            hl.bind(mod .. " + mouse_up", hl.dsp.focus({workspace = "e-1"})),
            hl.bind(mod .. " + mouse_down", hl.dsp.focus({workspace = "e+1"})),

            -- hl.bind(mods .." + R", hl.dsp.submap("resize"))
            -- hl.define_submap("resize", function()
            --   hl.bind("Alt + Return", hl.dps.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
            --   hl.bind("Alt + Shift + Return", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("Y", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("C", hl.dsp.layout("colresize +conf")),
            --   hl.bind("Shift + C", hl.dsp.layout("colresize -conf")),
            --   hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
            --   hl.bind("R", hl.dsp.layout("colresize 0.5")),
            --   binde = , Right, resizeactive, 30 0
            --   binde = , Left, resizeactive, 30 0
            --   binde = , Left, moveactive, -30 0
            --   binde = , Up, resizeactive, 0 30
            --   binde = , Up, moveactive, 0 -30
            --   binde = , Down, resizeactive, 0 30
            --
            --   binde = , L, resizeactive, 30 0
            --   binde = , H, resizeactive, 30 0
            --   binde = , H, moveactive, -30 0
            --   binde = , K, resizeactive, 0 30
            --   binde = , K, moveactive, 0 -30
            --   binde = , J, resizeactive, 0 30
            --
            --   binde = Shift, Right, resizeactive, -30 0
            --   binde = Shift, Right, moveactive, 30 0
            --   binde = Shift, Left, resizeactive, -30 0
            --   binde = Shift, Up, resizeactive, 0 -30
            --   binde = Shift, Down, resizeactive, 0 -30
            --   binde = Shift, Down, moveactive, 0 30
            --
            --   binde = Shift, L, resizeactive, -30 0
            --   binde = Shift, L, moveactive, 30 0
            --   binde = Shift, H, resizeactive, -30 0
            --   binde = Shift, K, resizeactive, 0 -30
            --   binde = Shift, J, resizeactive, 0 -30
            --   binde = Shift, J, moveactive, 0 30
            --   bind = $mods, R, submap, manage
            --   bind = $mod, R, submap, resizeTiled
            --   bind = , escape, submap, manage
            -- end)
            --
            -- bind = $mod, R, submap, resizeTiled
            -- submap = resizeTiled
            --   hl.bind("Alt + Return", hl.dps.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
            --   hl.bind("Alt + Shift + Return", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("Y", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("C", hl.dsp.layout("colresize +conf")),
            --   hl.bind("Shift + C", hl.dsp.layout("colresize -conf")),
            --   hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
            --   hl.bind("R", hl.dsp.layout("colresize 0.5")),
            --   binde = , Left, layoutmsg, colresize +0.1
            --   binde = , Right, layoutmsg, colresize -0.1
            --   binde = , H, layoutmsg, colresize +0.1
            --   binde = , L, layoutmsg, colresize -0.1
            --   bind = $mod, R, submap, manage
            --   bind = $mods, R, submap, resize
            --   bind = , escape, submap, manage
            -- submap = manage
            --
            -- bind = , M, submap, move
            --   submap = move
            --   hl.bind("Alt + Return", hl.dps.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
            --   hl.bind("Alt + Shift + Return", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("Y", hl.dps.window.fullscreen({ mode = "maximized", action = "toggle" }),
            --   hl.bind("C", hl.dsp.layout("colresize +conf")),
            --   hl.bind("Shift + C", hl.dsp.layout("colresize -conf")),
            --   hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
            --   hl.bind("R", hl.dsp.layout("colresize 0.5")),
            --   binde = , Left, moveactive, 10 0
            --   binde = , Right, moveactive, -10 0
            --   binde = , Up, moveactive, 0 -10
            --   binde = , Down, moveactive, 0 10
            --   binde = , H, moveactive, 30 0
            --   binde = , L, moveactive, -30 0
            --   binde = , K, moveactive, 0 -30
            --   binde = , J, moveactive, 0 30
            --   bind = , M, submap, manage
            --   bind = , escape, submap, manage
              
            hl.bind("Escape", hl.dsp.submap("reset"))

            hl.bind(mod .." + A", hl.dsp.submap("reset"))
          end)

        '';
    };
  };
}

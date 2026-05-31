{lib, ...}: let
  inherit (lib.generator) mkLuaInline;
in {
  wayland.windowManager.hyprland.settings = {
    config = {
      animations = {
        enabled = true;
      };
      curve = [
        (mkLuaInline "\"wind\" { type = \"bezier\", points = { {0.05, 0.9}, {0.1, 1.05} }")
        (mkLuaInline "\"winIn\" { type = \"bezier\", points = { {0.1, 1.1}, {0.1, 1.1} }")
        (mkLuaInline "\"winOut\" { type = \"bezier\", points = { {0.3, -0.3}, {0, 1} }")
        "liner, 1, 1, 1, 1"
        (mkLuaInline "\"liner\" { type = \"bezier\", points = { {1, 1}, {1, 1} }")
      ];
      animation = [
        (mkLuaInline "{ leaf = \"windows\", enabled = true, speed = 6, bezier = \"wind\", style = \"slide\"}")
        (mkLuaInline "{ leaf = \"windowsIn\", enabled = true, speed = 6, bezier = \"winIn\", style = \"slide\"}")
        (mkLuaInline "{ leaf = \"windowsOut\", enabled = true, speed = 5, bezier = \"winOut\", style = \"slide\"}")
        (mkLuaInline "{ leaf = \"windowsMove\", enabled = true, speed = 5, bezier = \"wind\", style = \"slide\"}")
        "border, 1, 1, liner"
        (mkLuaInline "{ leaf = \"border\", enabled = true, speed = 1, bezier = \"liner\" }")
        "borderangle, 1, 35, liner, loop"
        (mkLuaInline "{ leaf = \"borderangle\", enabled = true, speed = 35, bezier = \"liner\", style = \"loop\" }")
        "fade, 1, 10, default"
        (mkLuaInline "{ leaf = \"fade\", enabled = true, speed = 10, curev = \"default\" }")
        "workspaces, 1, 5, wind"
        (mkLuaInline "{ leaf = \"workspaces\", enabled = true, speed = 5, bezier = \"wind\" }")
        "specialWorkspace, 1, 5, wind, slidevert"
        (mkLuaInline "{ leaf = \"specialWorkspace\", enabled = true, speed = 5, bezier = \"wind\", style = \"slidevert\" }")
      ];
    };
  };
}

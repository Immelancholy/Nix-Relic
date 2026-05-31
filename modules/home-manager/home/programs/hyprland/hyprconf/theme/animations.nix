{lib, ...}: let
  inherit (lib.generator) mkLuaInLine;
in {
  wayland.windowManager.hyprland.settings = {
    config = {
      animations = {
        enabled = true;
      };
      curve = [
        (mkLuaInLine "\"wind\" { type = \"bezier\", points = { {0.05, 0.9}, {0.1, 1.05} }")
        (mkLuaInLine "\"winIn\" { type = \"bezier\", points = { {0.1, 1.1}, {0.1, 1.1} }")
        (mkLuaInLine "\"winOut\" { type = \"bezier\", points = { {0.3, -0.3}, {0, 1} }")
        "liner, 1, 1, 1, 1"
        (mkLuaInLine "\"liner\" { type = \"bezier\", points = { {1, 1}, {1, 1} }")
      ];
      animation = [
        (mkLuaInLine "{ leaf = \"windows\", enabled = true, speed = 6, bezier = \"wind\", style = \"slide\"}")
        (mkLuaInLine "{ leaf = \"windowsIn\", enabled = true, speed = 6, bezier = \"winIn\", style = \"slide\"}")
        (mkLuaInLine "{ leaf = \"windowsOut\", enabled = true, speed = 5, bezier = \"winOut\", style = \"slide\"}")
        (mkLuaInLine "{ leaf = \"windowsMove\", enabled = true, speed = 5, bezier = \"wind\", style = \"slide\"}")
        "border, 1, 1, liner"
        (mkLuaInLine "{ leaf = \"border\", enabled = true, speed = 1, bezier = \"liner\" }")
        "borderangle, 1, 35, liner, loop"
        (mkLuaInLine "{ leaf = \"borderangle\", enabled = true, speed = 35, bezier = \"liner\", style = \"loop\" }")
        "fade, 1, 10, default"
        (mkLuaInLine "{ leaf = \"fade\", enabled = true, speed = 10, curev = \"default\" }")
        "workspaces, 1, 5, wind"
        (mkLuaInLine "{ leaf = \"workspaces\", enabled = true, speed = 5, bezier = \"wind\" }")
        "specialWorkspace, 1, 5, wind, slidevert"
        (mkLuaInLine "{ leaf = \"specialWorkspace\", enabled = true, speed = 5, bezier = \"wind\", style = \"slidevert\" }")
      ];
    };
  };
}

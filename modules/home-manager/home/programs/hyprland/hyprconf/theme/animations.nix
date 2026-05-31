{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  wayland.windowManager.hyprland.extraConfig = /* Lua */ ''
    hl.config = ({
      animations = {
        enabled = true
      }
    })
      hl.curve("wind" { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} })
        hl.curve("winIn" { type = "bezier", points = { {0.1, 1.1}, {0.1, 1.1} })
        hl.curve("winOut" { type = "bezier", points = { {0.3, -0.3}, {0, 1} })
        "liner, 1, 1, 1, 1"
        hl.curve("liner" { type = "bezier", points = { {1, 1}, {1, 1} })
      ];
      animation = [
        hl.curve({ leaf = \"windows\", enabled = true, speed = 6, bezier = \"wind\", style = \"slide\"}")
        hl.curve({ leaf = \"windowsIn\", enabled = true, speed = 6, bezier = \"winIn\", style = \"slide\"}")
        hl.curve({ leaf = \"windowsOut\", enabled = true, speed = 5, bezier = \"winOut\", style = \"slide\"}")
        hl.curve({ leaf = \"windowsMove\", enabled = true, speed = 5, bezier = \"wind\", style = \"slide\"}")
        "border, 1, 1, liner"
        hl.curve({ leaf = \"border\", enabled = true, speed = 1, bezier = \"liner\" }")
        "borderangle, 1, 35, liner, loop"
        hl.curve({ leaf = \"borderangle\", enabled = true, speed = 35, bezier = \"liner\", style = \"loop\" }")
        "fade, 1, 10, default"
        hl.curve({ leaf = \"fade\", enabled = true, speed = 10, curev = \"default\" }")
        "workspaces, 1, 5, wind"
        hl.curve({ leaf = \"workspaces\", enabled = true, speed = 5, bezier = \"wind\" }")
        "specialWorkspace, 1, 5, wind, slidevert"
        hl.curve({ leaf = \"specialWorkspace\", enabled = true, speed = 5, bezier = \"wind\", style = \"slidevert\" }")
      ];
    };
  '';
}

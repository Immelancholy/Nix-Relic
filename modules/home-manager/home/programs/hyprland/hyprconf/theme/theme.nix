{
  lib,
  config,
  ...
}: let
  colors = config.stylix.lib.colors;
  inherit (lib.generators) mkLuaInLine;
in
  with colors; {
    wayland.windowManager.hyprland.settings = let
      rgb = color: "rgb(${color})";
      rgba = color: alpha: "rgb(${color}${alpha})";
      colorSettings = {
        general = {
          gaps_in = 3;
          gaps_out = 8;
          border_size = 2;
          "col.active_border" = lib.mkForce (mkLuaInLine "{colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40}");
          "col.inactive_border" = lib.mkForce (mkLuaInLine "{colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45}");
          resize_on_border = true;
        };
        group = {
          "col.border_active" = lib.mkForce (mkLuaInLine "{colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40}");
          "col.border_inactive" = lib.mkForce (mkLuaInLine "{colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45}");
          "col.border_locked_active" = lib.mkForce (mkLuaInLine "{colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40}");
          "col.border_locked_inactive" = lib.mkForce (mkLuaInLine "{colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45}");
          groupbar = {
            font_family = "JetBrainsMono Nerd Font Mono Bold";
            font_size = 12;
            gradients = false;
            text_color = lib.mkForce "${rgb base05}";
            "col.active" = lib.mkForce "${rgb base0E}";
            "col.inactive" = lib.mkForce "${rgba base07 "cc"}";
          };
        };

        decoration = {
          rounding = 20;
          shadow.enabled = false;

          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            vibrancy = 0.5;
            new_optimizations = true;
            ignore_opacity = true;
            xray = false;
            special = true;
          };
        };

        decoration = {
          dim_special = 0.3;
        };
      };
    in {config = colorSettings;};
  }

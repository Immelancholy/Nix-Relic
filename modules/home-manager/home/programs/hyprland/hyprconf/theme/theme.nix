{config, ...}: let
  colors = config.lib.stylix.colors;
in
  with colors; {
    wayland.windowManager.hyprland.extraConfig = let
      rgb = color: "rgb(${color})";
      rgba = color: alpha: "rgb(${color}${alpha})";
    in
      /*
      Lua
      */
      ''
        hl.config({
          general = {
            gaps_in = 3,
            gaps_out = 8,
            border_size = 2,
            col.active_border = {colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40},
            col.inactive_border = {colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45},
            resize_on_border = true,
          }
          group = {
            col.border_active = {colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40},
            col.border_inactive = {colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45},
            col.border_locked_active = {colors = \"${rgb base0E}\", \"${rgb base0C}\", \"${rgb base06}\", angle = 40},
            col.border_locked_inactive = {colors = \"${rgba base07 "cc"}\", \"${rgba base04 "cc"}\", angle = 45},
            groupbar = {
              font_family = "JetBrainsMono Nerd Font Mono Bold",
              font_size = 12,
              gradients = false,
              text_color = "${rgb base05}",
              col.active = "${rgb base0E}",
              col.inactive = "${rgba base07 "cc"}",
            },
          }

          decoration = {
            rounding = 20,
            shadow.enabled = false,

            blur = {
              enabled = true,
              size = 5,
              passes = 3,
              vibrancy = 0.5,
              new_optimizations = true,
              ignore_opacity = true,
              xray = false,
              special = true,
            },
          }

          decoration = {
            dim_special = 0.3,
          }
        })
      '';
  }

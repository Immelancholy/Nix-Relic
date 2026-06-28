{ config, ... }:
let
  inherit (config.lib.stylix) colors;
  inherit (config.stylix) fonts;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
in
with colors-hex;
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        enable_posix_regex = true;
        frame_color = "${base0C}c0";
        separator_color = "frame";
        highlight = "${base0C}c0";
        gaps_size = 4;
        frame_width = 2;
        corner_radius = 20;
        origin = "top-right";
        offset = "(54, 18)";
        width = "(0, 320)";
        height = "(0, 400)";
        alignment = "center";
        icon_corner_radius = 15;
        icon_position = "top";
        padding = 15;
        horizontal_padding = 10;
        max_icon_size = 256;
        font = "${fonts.monospace.name} ${toString fonts.sizes.popups}";
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        dmenu = "rofi -dmenu";
      };
      urgency_low = {
        background = "${base00}99";
        foreground = "${base05}";
      };
      urgency_normal = {
        background = "${base00}99";
        foreground = "${base05}";
      };
      urgency_critical = {
        background = "${base00}99";
        foreground = "${base05}";
        frame_color = "${base08}c0";
      };
    };
  };
}

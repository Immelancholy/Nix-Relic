{config, ...}: let
  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";
  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  mauve = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        enable_posix_regex = true;
        frame_color = "${mauve}c0";
        separator_color = "frame";
        highlight = "${mauve}c0";
        gaps_size = 4;
        frame_width = 2;
        corner_radius = 20;
        origin = "top-right";
        offset = "(54, 18)";
        width = "(0, 280)";
        height = "(0, 330)";
        alignment = "center";
        icon_corner_radius = 15;
        icon_position = "top";
        padding = 15;
        horizontal_padding = 10;
        max_icon_size = 256;
        font = "JetBrainsMono Nerd Font Mono 9";
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        dmenu = "rofi -dmenu";
      };
      urgency_low = {
        background = "${base}99";
        foreground = "${text}";
      };
      urgency_normal = {
        background = "${base}99";
        foreground = "${text}";
      };
      urgency_critical = {
        background = "${base}99";
        foreground = "${text}";
        frame_color = "${red}c0";
      };
    };
  };
}

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
  programs.inori = {
    enable = true;
    settings = {
      qwerty_keybindings = true;
      theme = {
        item_highlight_active = {
          fg = "${base}";
          bg = "${mauve}";
        };
        item_highlight_inactive = {
          fg = "${text}";
        };
        block_active = {
          fg = "${mauve}";
        };
        playing = {
          fg = "${teal}";
        };
        paused = {
          fg = "${yellow}";
        };
        status_artist = {
          fg = "${red}";
        };
        status_album = {
          fg = "${mauve}";
        };
        album = {
          fg = "${mauve}";
        };
      };
    };
  };
}

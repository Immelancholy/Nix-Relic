{
  pkgs,
  config,
  ...
}: let
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
  home.packages = with pkgs; [
    inori
  ];
  xdg.configFile."inori/config.toml".text = ''
    qwerty_keybindings = true

    [theme.item_highlight_active]
    fg = "${mantle}"
    bg = "${mauve}"

    [theme.item_highlight_inactive]
    fg = "${text}"

    [theme.block_active]
    fg = "${mauve}"

    [theme.playing]
    fg = "${teal}"
    add_modifier = "HIDDEN"

    [theme.paused]
    fg = "${yellow}"

    [theme.status_artist]
    fg = "${red}"
    add_modifier = "HIDDEN"

    [theme.status_album]
    fg = "${mauve}"
    add_modifier = "HIDDEN"

    [theme.album]
    fg = "${mauve}"
  '';
}

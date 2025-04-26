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
  programs.cava = {
    enable = true;
    settings = {
      general = {
        framerate = 144;
        sensitivity = 100;
        bars = 0;
        bar_width = 1;
        bar_spacing = 0;
      };
      output = {
        method = "noncurses";
        channels = "stereo";
        mono_option = "average";
      };
      input = {
        method = "fifo";
        source = "/tmp/mpd_cava.fifo";
      };
      smoothing = {
        monstercat = 1;
        waves = 0;
        noise_reduction = 72;
      };
    };
  };
}

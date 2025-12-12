{config, ...}: let
  text = "#${config.lib.stylix.colors.base05}";
  red = "#${config.lib.stylix.colors.base08}";
  teal = "#${config.lib.stylix.colors.base0C}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  programs.zarumet = {
    enable = true;
    settings = {
      colors = {
        border = text;
        title = text;
        album = flamingo;
        artist = red;
        status = teal;
      };
    };
  };
}

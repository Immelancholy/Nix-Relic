{
  config,
  inputs,
  ...
}: let
  text = "#${config.lib.stylix.colors.base05}";
  red = "#${config.lib.stylix.colors.base08}";
  teal = "#${config.lib.stylix.colors.base0C}";
  flamingo = "#${config.lib.stylix.colors.base0F}";
in {
  imports = [
    inputs.nix-relic.inputs.zarumet.homeModules.default
  ];
  programs.zarumet = {
    enable = true;
    settings = {
      mpd = {
        address = "${config.services.mpd.network.listenAddress}:${builtins.toString config.services.mpd.network.port}";
      };
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

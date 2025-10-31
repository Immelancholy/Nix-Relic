{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}: let
  cavaCfg = pkgs.nr.cavaCfg.override {
    color1 = "#${config.lib.stylix.colors.base0E}";
    color2 = "#${config.lib.stylix.colors.base0D}";
    color3 = "#${config.lib.stylix.colors.base0C}";
    color4 = "#${config.lib.stylix.colors.base0B}";
    color5 = "#${config.lib.stylix.colors.base0A}";
    color6 = "#${config.lib.stylix.colors.base09}";
    color7 = "#${config.lib.stylix.colors.base08}";
    framerate = "${builtins.toString nixosConfig.nix-relic.cava.framerate}";
    noiseReduction = "${builtins.toString nixosConfig.nix-relic.cava.noiseReduction}";
  };
in {
  home = {
    activation = {
      cavaCfg = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run cavaCfg
      '';
    };
    extraActivationPath = [
      cavaCfg
    ];
  };
}

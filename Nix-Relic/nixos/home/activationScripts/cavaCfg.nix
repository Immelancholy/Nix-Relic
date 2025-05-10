{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};
  cavaCfg = nrm.cavaCfg.override {
    color1 = "#${config.lib.stylix.colors.base0E}";
    color2 = "#${config.lib.stylix.colors.base0D}";
    color3 = "#${config.lib.stylix.colors.base0C}";
    color4 = "#${config.lib.stylix.colors.base0B}";
    color5 = "#${config.lib.stylix.colors.base0A}";
    color6 = "#${config.lib.stylix.colors.base09}";
    color7 = "#${config.lib.stylix.colors.base08}";
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

{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};
  cavaCfg = nrm.cavaCfg.override {
    red = "#${config.lib.stylix.colors.base08}";
    peach = "#${config.lib.stylix.colors.base09}";
    yellow = "#${config.lib.stylix.colors.base0A}";
    green = "#${config.lib.stylix.colors.base0B}";
    teal = "#${config.lib.stylix.colors.base0C}";
    blue = "#${config.lib.stylix.colors.base0D}";
    mauve = "#${config.lib.stylix.colors.base0E}";
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

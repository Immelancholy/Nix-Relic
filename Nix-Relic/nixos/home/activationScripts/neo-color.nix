{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};

  neo-color = nrm.neo-color.override {
    color1 = "${config.lib.stylix.colors.base0F}";
    color2 = "${config.lib.stylix.colors.base0D}";
    color3 = "${config.lib.stylix.colors.base0E}";
    color4 = "${config.lib.stylix.colors.base0C}";
    color5 = "${config.lib.stylix.colors.base05}";
  };
  colortrans = nrm.colortrans;
in {
  home = {
    activation = {
      neo-color = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run neo-color
      '';
    };
    extraActivationPath = [
      neo-color
      colortrans
      pkgs.gawk
    ];
  };
}

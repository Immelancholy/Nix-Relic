{
  pkgs,
  config,
  lib,
  ...
}: let
  neo-color = pkgs.nrm.neo-color.override {
    color1 = "${config.lib.stylix.colors.base0F}";
    color2 = "${config.lib.stylix.colors.base0D}";
    color3 = "${config.lib.stylix.colors.base0E}";
    color4 = "${config.lib.stylix.colors.base0C}";
    color5 = "${config.lib.stylix.colors.base05}";
  };
in {
  home = {
    activation = {
      neo-color = lib.hm.dag.entryAfter ["writeBoundary"] ''
        run neo-color
      '';
    };
    extraActivationPath = [
      neo-color
    ];
  };
}

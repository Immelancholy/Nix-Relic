{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};

  neo-color = nrm.neo-color.override {
    base = "${config.lib.stylix.colors.base00}";
    mantle = "${config.lib.stylix.colors.base01}";
    surface0 = "${config.lib.stylix.colors.base02}";
    surface1 = "${config.lib.stylix.colors.base03}";
    surface2 = "${config.lib.stylix.colors.base04}";
    text = "${config.lib.stylix.colors.base05}";
    rosewater = "${config.lib.stylix.colors.base06}";
    lavender = "${config.lib.stylix.colors.base07}";
    red = "${config.lib.stylix.colors.base08}";
    peach = "${config.lib.stylix.colors.base09}";
    yellow = "${config.lib.stylix.colors.base0A}";
    green = "${config.lib.stylix.colors.base0B}";
    teal = "${config.lib.stylix.colors.base0C}";
    blue = "${config.lib.stylix.colors.base0D}";
    mauve = "${config.lib.stylix.colors.base0E}";
    flamingo = "${config.lib.stylix.colors.base0F}";
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

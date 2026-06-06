{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.lib.stylix) colors;
  neo-color =
    with colors;
    pkgs.nr.neo-color.override {
      color1 = "${base0F}";
      color2 = "${base0D}";
      color3 = "${base0E}";
      color4 = "${base0C}";
      color5 = "${base05}";
    };
in
{
  home = {
    activation = {
      neo-color = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run neo-color
      '';
    };
    extraActivationPath = [
      neo-color
    ];
  };
}

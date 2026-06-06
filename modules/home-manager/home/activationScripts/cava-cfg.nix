{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}:
let
  inherit (config.lib.stylix) colors;
  mkHex = colors: builtins.mapAttrs (_: value: "#${value}") colors;
  colors-hex = mkHex colors;
  cavaCfg =
    with colors-hex;
    pkgs.cava-cfg.override {
      color1 = "${base0E}";
      color2 = "${base0D}";
      color3 = "${base0C}";
      color4 = "${base0B}";
      color5 = "${base0A}";
      color6 = "${base09}";
      color7 = "${base08}";
      framerate = "${toString nixosConfig.nix-relic.cava.framerate}";
      noiseReduction = "${toString nixosConfig.nix-relic.cava.noiseReduction}";
    };
in
{
  home = {
    activation = {
      cavaCfg = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run cavaCfg
      '';
    };
    extraActivationPath = [
      cava-cfg
    ];
  };
}
